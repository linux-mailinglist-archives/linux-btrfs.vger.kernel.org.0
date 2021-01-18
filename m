Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4F2F9F3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 13:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbhARMNi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 07:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389011AbhARMN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 07:13:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0CC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 04:12:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d13so16193865wrc.13
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 04:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+qkgFR2jJQHEUccXB62BIkO1uNDvv917LiflSxEAZQ4=;
        b=tqgC/BCf/fBOmJ6A45eblo98jpPj25cr6+rvnoWifJc4BuphHzQwks+KuHFbxR8Z34
         cVc7m5RVitc+BON4D6X6q5W4rld2BfQt6cxnYaJvDNhz7vzx4BstPRuokDnvjtPvwx1Z
         oFrD5SA6eSt0C314wI50rQGFduAFQpWUK7DL3fjsQkgHzp9MurcBMs483yQOjRDAFRh0
         YLGC03muV14LrSfivZGcx2tRezw04ELe78se401OGlx1g4NKR27UjcOfLWcUKWl0yf9h
         XDwU5697lhbn/it3khjGH0WD4Dz5Qy0NbnjY2sIgBm/y3R+U7af8skqqE/CA4PQQeUVq
         kj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+qkgFR2jJQHEUccXB62BIkO1uNDvv917LiflSxEAZQ4=;
        b=E9G+s1PaOXw/O5AWFKGfC8nO/iunhjCNODDpcGlEuIqOqqJkXtH65vzsD+4TKDqy6o
         h4jkksDzboxZypP9JJnNWODvqB6RGz962CgJBciQrXbvj6GHpjXyH8C5ZBkfSWHdc56X
         uJgoHZPldKXAEwIJ6Ses1Q1SOd7snFazsBwR1ZSZgUxpSkyhQo/6xFN+qDgaWxVtiVdX
         PpGgkgkJo6UNP/9ygD+fyB6sYgLYk+caVeh+CpK4VwsUktnLFf+n4JfTcAxsrorSrh91
         MXk+cHTvFOIfxnrDAU5hsjcgwGGOLNEqBl1+NHOGXjFvBAdb3yttshF3N+ljto867FcN
         oADA==
X-Gm-Message-State: AOAM532Oi5wNdH5FBURM6QxwmJvbfm1vza82aSMJ8P7IQW43NWy9HnGZ
        9i0NATmi68rWnk6CcXi0oZyeXfNHJXFrnIMqO+hv+g==
X-Google-Smtp-Source: ABdhPJy/+AXOGtAhT52kluwsQA3X8aZun53yF3LRkQXyjQoWgDw9ioFiuJyKIrHASGF+8Zbt+cIs6Z03hIRcnlWkSzU=
X-Received: by 2002:a05:6000:185:: with SMTP id p5mr25394816wrx.403.1610971962425;
 Mon, 18 Jan 2021 04:12:42 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk> <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com> <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com> <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com> <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
In-Reply-To: <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Mon, 18 Jan 2021 04:12:31 -0800
Message-ID: <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The offending system is indeed ARMv7 (specifically a Marvell ARMADA=C2=AE
388), but I believe the Broadcom BCM2835 in my Raspberry Pi is
actually ARMv6 (with hardware float support).

On Mon, Jan 18, 2021 at 4:01 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/1/18 =E4=B8=8B=E5=8D=887:55, Erik Jensen wrote:
> > On Mon, Jan 18, 2021 at 3:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> >> On 2021/1/18 =E4=B8=8B=E5=8D=886:33, Erik Jensen wrote:
> >>> I ended up having other priorities occupying my time since 2019, and =
the
> >>> "solution" of exporting the individual drives on my NAS using NBD and
> >>> mounting them on my desktop worked, even if it wasn't pretty.
> >>>
> >>> However, I am currently looking into Syncthing, which I would like to
> >>> run on the NAS directly. That would, of course, require accessing the
> >>> filesystem directly on the NAS rather than just exporting the raw
> >>> devices, which means circling back to this issue.
> >>>
> >>> After updating my NAS, I have determined that the issue still occurs
> >>> with Linux 5.8.
> >>>
> >>> What's the next best step for debugging the issue? Ideally, I'd like =
to
> >>> help track down the issue to find a proper fix, rather than just tryi=
ng
> >>> to bypass the issue. I wasn't sure if the suggestion to comment out
> >>> btrfs_verify_dev_extents() was more geared toward the former or the l=
atter.
> >>
> >> After rewinding my memory on this case, the problem is really that the
> >> ARM btrfs kernel is reading garbage, while X86 or ARM user space tool
> >> works as expected.
> >>
> >> Can you recompile your kernel on the ARM board to add extra debugging
> >> messages?
> >> If possible, we can try to add some extra debug points to bombarding
> >> your dmesg.
> >>
> >> Or do you have other ARM boards to test the same fs?
> >>
> >>
> >> Thanks,
> >> Qu
> >
> > It's pretty easy to build a kernel with custom patches applied, though
> > the actual building takes a while, so I'd be happy to add whatever
> > debug messages would be useful. I also have an old Raspberry Pi
> > (original model B) I can dig out and try to get going, tomorrow. I
> > can't hook it up to the drives directly, but I should be able to
> > access them via NBD like I was doing from my desktop.
>
> RPI 1B would be a little slow but should be enough to expose the
> problem, if the problem is for all arm builds (as long as you're also
> using armv7 for the offending system).
>
> Thanks,
> Qu
>
> > If I can't get
> > that going for whatever reason, I could also try running an emulated
> > ARM system with QEMU.
> >
> >>>
> >>> On Fri, Jun 28, 2019 at 1:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com
> >>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>
> >>>
> >>>
> >>>      On 2019/6/28 =E4=B8=8B=E5=8D=884:00, Erik Jensen wrote:
> >>>       >> So it's either the block layer reading some wrong from the d=
isk
> >>>      or btrfs
> >>>       >> layer doesn't do correct endian convert.
> >>>       >
> >>>       > My ARM board is running in little endian mode, so it doesn't =
seem
> >>>      like
> >>>       > endianness should be an issue. (It is 32-bits versus my deskt=
op's 64,
> >>>       > though.) I've also tried exporting the drives via NBD to my x=
86_64
> >>>       > system, and that worked fine, so if the problem is under btrf=
s, it
> >>>       > would have to be in the encryption layer, but fsck succeeding=
 on the
> >>>       > ARM board would seem to rule that out, as well.
> >>>       >
> >>>       >> Would you dump the following data (X86 and ARM should output=
 the
> >>>      same
> >>>       >> content, thus one output is enough).
> >>>       >> # btrfs ins dump-tree -b 17628726968320 /dev/dm-3
> >>>       >> # btrfs ins dump-tree -b 17628727001088 /dev/dm-3
> >>>       >
> >>>       > Attached, and also 17628705964032, since that's the block
> >>>      mentioned in
> >>>       > my most recent mount attempt (see below).
> >>>
> >>>      The trees are completely fine.
> >>>
> >>>      So it should be something else causing the problem.
> >>>
> >>>       >
> >>>       >> And then, for the ARM system, please apply the following dif=
f,
> >>>      and try
> >>>       >> mount again.
> >>>       >> The diff adds extra debug info, to exam the vital members of=
 a
> >>>      tree block.
> >>>       >>
> >>>       >> Correct fs should output something like:
> >>>       >>   BTRFS error (device dm-4): bad tree block start, want 3040=
8704
> >>>      have 0
> >>>       >>   tree block gen=3D4 owner=3D5 nritems=3D2 level=3D0
> >>>       >>   csum:
> >>>       >>
> >>>      a304e483-0000-0000-0000-00000000000000000000-0000-0000-0000-0000=
00000000
> >>>       >>
> >>>       >> The csum one is the most important one, if there aren't so m=
any
> >>>      zeros,
> >>>       >> it means at that timing, btrfs just got a bunch of garbage, =
thus we
> >>>       >> could do further debug.
> >>>       >
> >>>       > [  131.725573] BTRFS info (device dm-1): disk space caching i=
s
> >>>      enabled
> >>>       > [  131.731884] BTRFS info (device dm-1): has skinny extents
> >>>       > [  133.046145] BTRFS error (device dm-1): bad tree block star=
t, want
> >>>       > 17628705964032 have 2807793151171243621
> >>>       > [  133.055775] tree block gen=3D7888986126946982446
> >>>       > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> >>>       > [  133.065661] csum:
> >>>       >
> >>>      416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41c=
ba9656fc
> >>>
> >>>      Completely garbage here, so I'd say the data we got isn't what w=
e want.
> >>>
> >>>       > [  133.108383] BTRFS error (device dm-1): bad tree block star=
t, want
> >>>       > 17628705964032 have 2807793151171243621
> >>>       > [  133.117999] tree block gen=3D7888986126946982446
> >>>       > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> >>>       > [  133.127756] csum:
> >>>       >
> >>>      416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41c=
ba9656fc
> >>>
> >>>      But strangely, the 2nd try still gives us the same result, if it=
's
> >>>      really some garbage, we should get some different result.
> >>>
> >>>       > [  133.136241] BTRFS error (device dm-1): failed to verify de=
v
> >>>      extents
> >>>       > against chunks: -5
> >>>
> >>>      You can try to skip the dev extents verification by commenting o=
ut the
> >>>      btrfs_verify_dev_extents() call in disk-io.c::open_ctree().
> >>>
> >>>      It may fail at another location though.
> >>>
> >>>      The more strange part is, we have the device tree root node read=
 out
> >>>      without problem.
> >>>
> >>>      Thanks,
> >>>      Qu
> >>>
> >>>       > [  133.166165] BTRFS error (device dm-1): open_ctree failed
> >>>       >
> >>>       > I copied some files over last time I had it mounted on my des=
ktop,
> >>>       > which may be why it's now failing at a different block.
> >>>       >
> >>>       > Thanks!
> >>>       >
> >>>
