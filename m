Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463B52F9EDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391083AbhARL4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 06:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391245AbhARLz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 06:55:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBAC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 03:55:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c124so13327163wma.5
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ax3CQsUGVCjOIK6Qtn277NleeVMwgiHjPMqrKO34ogs=;
        b=nUOT7aQEjhosaf3v4LJP+jxzIIQDMwEXOWQ7Me4I5eyE7J55x6qxLwMzLSjF3g2Zei
         oU4BMbrS25IFOA9NB5x14l7pn4xEIryr26+5700TJs1Jb8kDKnjsAOy9QLl/urVwZomj
         R+fdpHSE9SiAKy6RL/UL60K4UM+7BQS060zzo+sHXM5XWk2aHP7jPL5zID4UR6XmKYoP
         MTma8//LenX/+0PEpBmP6EtMbRjM38kjDVaueDs0cmBlEWdWqDwwZHymM1zz4WfEfsiI
         9MB3NMs7bkdQ8Ixf6w7MFvD0Ae2Rx1tH1hZ2RKznmmGFGROmwjZqVX9bPuAR5M3QT8GY
         ysAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ax3CQsUGVCjOIK6Qtn277NleeVMwgiHjPMqrKO34ogs=;
        b=jTjabsV7q15+Rkgw08soH0OmXO9nB95RjPFqNosdD5NuNH6c8Y/bRwh6bTwHkcdFeL
         BhOKmzWK8WAsuhaqfE0cCci+epYCwtQHHsE97BkXRcNEB2u4R4ex1X4eIycdPUwT+kOu
         JviEO7DconxlPSyJs//j08gqWwgVFs57U7GVIovYLHoK0HatobkYz9bj2lAdVm82G2yx
         jAFFlJbcBEX4A30xofLVIysIlUlF96N9XqooKTpZDDhH/zSQ16hTVpPjm0fSiNRzUrXn
         awWWPXlFezo20MSC5gG+88i7pFl8pfKgyYp4ctEqPDwkBiaRjU8B1Q/MXTABieRtRj8M
         BwHw==
X-Gm-Message-State: AOAM531RYz25zyXgvM0HoIpEJBWRaRLmzoM3GalzpzE1x0Zg0cy88FMI
        EIMUG5hX9NAQnQ1inEIQ3M3EihOh1VS2qqVJW4tpPRx8uxiYHw==
X-Google-Smtp-Source: ABdhPJzBAQNXB0NmA6hvUbt0VwAPG+XWhDC91khV8bgbtgdi5upDNFXla8yBy+hhpKZTuHFhK6CHXnjlxRMLixXbJpU=
X-Received: by 2002:a1c:9a90:: with SMTP id c138mr5291715wme.147.1610970914012;
 Mon, 18 Jan 2021 03:55:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk> <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com> <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com> <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
In-Reply-To: <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Mon, 18 Jan 2021 03:55:02 -0800
Message-ID: <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 18, 2021 at 3:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2021/1/18 =E4=B8=8B=E5=8D=886:33, Erik Jensen wrote:
> > I ended up having other priorities occupying my time since 2019, and th=
e
> > "solution" of exporting the individual drives on my NAS using NBD and
> > mounting them on my desktop worked, even if it wasn't pretty.
> >
> > However, I am currently looking into Syncthing, which I would like to
> > run on the NAS directly. That would, of course, require accessing the
> > filesystem directly on the NAS rather than just exporting the raw
> > devices, which means circling back to this issue.
> >
> > After updating my NAS, I have determined that the issue still occurs
> > with Linux 5.8.
> >
> > What's the next best step for debugging the issue? Ideally, I'd like to
> > help track down the issue to find a proper fix, rather than just trying
> > to bypass the issue. I wasn't sure if the suggestion to comment out
> > btrfs_verify_dev_extents() was more geared toward the former or the lat=
ter.
>
> After rewinding my memory on this case, the problem is really that the
> ARM btrfs kernel is reading garbage, while X86 or ARM user space tool
> works as expected.
>
> Can you recompile your kernel on the ARM board to add extra debugging
> messages?
> If possible, we can try to add some extra debug points to bombarding
> your dmesg.
>
> Or do you have other ARM boards to test the same fs?
>
>
> Thanks,
> Qu

It's pretty easy to build a kernel with custom patches applied, though
the actual building takes a while, so I'd be happy to add whatever
debug messages would be useful. I also have an old Raspberry Pi
(original model B) I can dig out and try to get going, tomorrow. I
can't hook it up to the drives directly, but I should be able to
access them via NBD like I was doing from my desktop. If I can't get
that going for whatever reason, I could also try running an emulated
ARM system with QEMU.

> >
> > On Fri, Jun 28, 2019 at 1:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com
> > <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >
> >
> >
> >     On 2019/6/28 =E4=B8=8B=E5=8D=884:00, Erik Jensen wrote:
> >      >> So it's either the block layer reading some wrong from the disk
> >     or btrfs
> >      >> layer doesn't do correct endian convert.
> >      >
> >      > My ARM board is running in little endian mode, so it doesn't see=
m
> >     like
> >      > endianness should be an issue. (It is 32-bits versus my desktop'=
s 64,
> >      > though.) I've also tried exporting the drives via NBD to my x86_=
64
> >      > system, and that worked fine, so if the problem is under btrfs, =
it
> >      > would have to be in the encryption layer, but fsck succeeding on=
 the
> >      > ARM board would seem to rule that out, as well.
> >      >
> >      >> Would you dump the following data (X86 and ARM should output th=
e
> >     same
> >      >> content, thus one output is enough).
> >      >> # btrfs ins dump-tree -b 17628726968320 /dev/dm-3
> >      >> # btrfs ins dump-tree -b 17628727001088 /dev/dm-3
> >      >
> >      > Attached, and also 17628705964032, since that's the block
> >     mentioned in
> >      > my most recent mount attempt (see below).
> >
> >     The trees are completely fine.
> >
> >     So it should be something else causing the problem.
> >
> >      >
> >      >> And then, for the ARM system, please apply the following diff,
> >     and try
> >      >> mount again.
> >      >> The diff adds extra debug info, to exam the vital members of a
> >     tree block.
> >      >>
> >      >> Correct fs should output something like:
> >      >>   BTRFS error (device dm-4): bad tree block start, want 3040870=
4
> >     have 0
> >      >>   tree block gen=3D4 owner=3D5 nritems=3D2 level=3D0
> >      >>   csum:
> >      >>
> >     a304e483-0000-0000-0000-00000000000000000000-0000-0000-0000-0000000=
00000
> >      >>
> >      >> The csum one is the most important one, if there aren't so many
> >     zeros,
> >      >> it means at that timing, btrfs just got a bunch of garbage, thu=
s we
> >      >> could do further debug.
> >      >
> >      > [  131.725573] BTRFS info (device dm-1): disk space caching is
> >     enabled
> >      > [  131.731884] BTRFS info (device dm-1): has skinny extents
> >      > [  133.046145] BTRFS error (device dm-1): bad tree block start, =
want
> >      > 17628705964032 have 2807793151171243621
> >      > [  133.055775] tree block gen=3D7888986126946982446
> >      > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> >      > [  133.065661] csum:
> >      >
> >     416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba9=
656fc
> >
> >     Completely garbage here, so I'd say the data we got isn't what we w=
ant.
> >
> >      > [  133.108383] BTRFS error (device dm-1): bad tree block start, =
want
> >      > 17628705964032 have 2807793151171243621
> >      > [  133.117999] tree block gen=3D7888986126946982446
> >      > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> >      > [  133.127756] csum:
> >      >
> >     416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba9=
656fc
> >
> >     But strangely, the 2nd try still gives us the same result, if it's
> >     really some garbage, we should get some different result.
> >
> >      > [  133.136241] BTRFS error (device dm-1): failed to verify dev
> >     extents
> >      > against chunks: -5
> >
> >     You can try to skip the dev extents verification by commenting out =
the
> >     btrfs_verify_dev_extents() call in disk-io.c::open_ctree().
> >
> >     It may fail at another location though.
> >
> >     The more strange part is, we have the device tree root node read ou=
t
> >     without problem.
> >
> >     Thanks,
> >     Qu
> >
> >      > [  133.166165] BTRFS error (device dm-1): open_ctree failed
> >      >
> >      > I copied some files over last time I had it mounted on my deskto=
p,
> >      > which may be why it's now failing at a different block.
> >      >
> >      > Thanks!
> >      >
> >
