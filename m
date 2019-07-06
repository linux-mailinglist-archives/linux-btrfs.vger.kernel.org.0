Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4836961263
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfGFRg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 13:36:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38639 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfGFRg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Jul 2019 13:36:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so12544141wmj.3
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jul 2019 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TBIwLoVA0TWa1MeVrx/D1dgPVGbib1Q9GSpVAXURIw=;
        b=rbHgAKJurpwJzefLIg5RNvc6CWCWLhwHDhyGMqe1hOrz9uHbzHPCmUOjSYSlreCOlf
         f9KD8K2O2Ue8YJFkCIR+V1kbJqSeqmvcDMF3O+l6FoSGc78F7I2VbXEO7KMqYiu0e8dK
         og/S++GlJe2PkN8BI3oXSQWwJVTKuKZ7DYJQdZj8TPxFP6Zx45+XQCKbxO0UXMV+H/8v
         t0953UGOiCKlrNqyu4cgHtxtipOI1VD1cB+sk/ledRTMBa2RZYDsYMxYVTGI4LCizmie
         WHW3W8vvQDgPgAmnqr/dh/P6MOF9RsMJvQTJ+bYNcsbtswBwCHtKZz5CL0oqFjueYMBu
         W2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TBIwLoVA0TWa1MeVrx/D1dgPVGbib1Q9GSpVAXURIw=;
        b=KWdNorkuthtRCvO87XXoXuZVHyL7mh8ZNfANE1133sa1mrFvMPOEv6grAM7E02cHq2
         ZC/cW3flN2jeGYM43ESVgGdnxJg0DssE9cSl4BbcsU0/0q3k4AF0WENQ/XPX0xL+oYJV
         1JNgY3Irz7VGYzT1JJBGkyGNHPjjFTzHx422EDwA7mxeQSHF0eowSJi2LjAmkm+carOA
         hKfbMUN4rh8E/C1onIt2me4Pw/2CylbVIa+UFzXbFgrc0DI3bdWkygKwW0G5vFg8CaUN
         ePwweeMgSVh15OoQ0KxySv/HaS8cwyAU+RgOm4duYm0dJnZdyq3NbEuSf+HwwGfEdzDv
         2NVA==
X-Gm-Message-State: APjAAAUzLOwY3mpNd3Mz+pjXN0rG5bqI1xHFJyeESas8b9MKOhQuiSmL
        YjHQB2l1nEWDw7rXZ1VG0bt4ejy5Y8Emo9pr2CHtEA==
X-Google-Smtp-Source: APXvYqwW6SCgDJLCtUW4037D+jx9p712K+1W9KO8V/waBVpKFNufHGgGEcn3Uq6PteFLzoevV6PRBvAyaMZllgstVcM=
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr8643770wms.8.1562434584217;
 Sat, 06 Jul 2019 10:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <CAJCQCtRhXukLGrWTK1D5TLRhxwF6e31oewOSNDg2TAxSanavMA@mail.gmail.com>
 <a4920d21-3c90-9a96-9b44-f90d7b5eed3a@gmail.com> <CAJCQCtS87cQV4PWuDRaQmmY-N03XmGqN2hh8EQv8BqqVGRuxbw@mail.gmail.com>
 <0212c1f0-f02d-bf0f-5748-b1332b6bbfad@gmail.com>
In-Reply-To: <0212c1f0-f02d-bf0f-5748-b1332b6bbfad@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 6 Jul 2019 11:36:13 -0600
Message-ID: <CAJCQCtQVMnP5G=Hp0tnoXuc+_j0Wg3heb1exnNj2nND4Mc3aiw@mail.gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 9:38 PM Vladimir Panteleev
<thecybershadow@gmail.com> wrote:
>
> On 06/07/2019 02.38, Chris Murphy wrote:
> > It's a really good question for developers if there is a good reason
> > to permit rw mount of a volume that's missing two or more devices for
> > raid 1, 10, or 5; and missing three or more for raid6. I cannot think
> > of a good reason to allow degraded,rw mounts for a raid10 missing two
> > devices.
>
> Sorry, the code currently indeed does not permit mounting a RAID10
> filesystem with more than one missing device in rw. I needed to patch my
> kernel to force it to allow it, as I was working on the assumption that
> the two remaining drives contained a copy of all data (which turned out
> to be true).

Oh gotcha. I glossed over that. Ahh yeah, so we're kinda back to end
user sabotage in that case. :-)

The thing about Btrfs, it has very little pre-defined on disk layout.
The only things explicitly assigned locations are the superblocks. The
super points to the start of root tree and chunk tree, and those can
start literally anywhere. When block groups are mirrored, which device
they appear on, and the physical location on each device, is also not
consistent.

In other words, you could do this test a bunch of times, and then as
the file system ages it becomes even more non-deterministic, the
likelihood of  some data loss when losing two devices on a raid10 very
quickly approaches 100%.



>
> > Wow that's really interesting. So you did 'btrfs replace start' for
> > one of the missing drive devid's, with a loop device as the
> > replacement, and that worked and finished?!
>
> Yes, that's right.

I suspect it's lucky. There's every reason to believe in a repeat
scenario you can end up with raid1 block groups only on to two missing
devices.


>
> > Does this three device volume mount rw and not degraded? I guess it
> > must have because 'btrfs fi us' worked on it.
> >
> >          devid    1 size 7.28TiB used 2.71TiB path /dev/sdd1
> >          devid    2 size 7.28TiB used 22.01GiB path /dev/loop0
> >          devid    3 size 7.28TiB used 2.69TiB path /dev/sdf1
>
> Indeed - with the loop device attached, I can mount the filesystem rw
> just fine without any mount flags, with a stock kernel.
>
> > OK so what happens now if you try to 'btrfs device remove /dev/loop0' ?
>
> Unfortunately it fails in the same way (warning followed by "kernel
> BUG"). The same thing happens if I try to rebalance the metadata.

That seems like a legitimate bug even if the way you got to this point
is sorta screwy and definitely an edge case.


>
> > Well there's definitely something screwy if Btrfs needs something on a
> > missing drive, which is indicated by its refusal to remove it from the
> > volume, and yet at same time it's possible to e.g. rsync every file to
> > /dev/null without any errors. That's a bug somewhere.
>
> As I understand, I don't think it actually "needs" any data from that
> device, it's just having trouble updating some metadata as it tries to
> move one redundant copy of the data from there to somewhere else. It's
> not refusing to remove the device either, rather it tries and fails at
> doing so.

I think the developers would say anytime the user space tools permit
an action that results in a kernel warning, it's a bug. The priority
of fixing that bug will of course depend on the likelihood of users
running into it, and the scope of the fix, and the resources required.



>
> > I'm not a developer but a dev very well might need to have a simple
> > reproducer for this in order to locate the problem. But the call trace
> > might tell them what they need to know. I'm not sure.
>
> What I'm going to try to do next is to create another COW layer on top
> of the three devices I have, attach them to a virtual machine, and boot
> that (as it's not fun to reboot the physical machine each time the code
> crashes). Then I could maybe poke the related kernel code to try to
> understand the problem better.

I don't really understand the code, but then also I don't know what's
happening as it tries to remove the device and what logical problems
Btrfs is running into that eventually causes the warning. It might be
there's already confusion with on-disk metadata.

Btrfs debugging isn't enabled in default kernels, it's vaguely
possible that would reveal more information. And then the integrity
checker can be incredibly verbose, as in so verbose you definitely do
not want to be writing out a persistent kernel message log to the same
Btrfs file system you're checking. The integrity checker also isn't
enabled in distro kernels. It's both a compile time option as well as
a mount time option (separate for metadata only and with data
checking). But i can't give any advice on what mask options to use
that might help reveal what's going on and where Btrfs gets tripped
up. It does look like it's related to the global reserve, which is
something of a misnomer. It's not some separate thing, it's really
space within a metadata block group.

What still would be interesting is if there's a way to reproduce this
layout, where user space tools permit device removal but then the
kernel splats with this warning.

-- 
Chris Murphy
