Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB21D3D8234
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhG0V6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhG0V6q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:58:46 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C1C061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:58:45 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id z18so465963ybg.8
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=anck6fo2s+mPb68AfQbcgyo8Kx5a9s1w+YI6ylEmT2I=;
        b=AhfLv4RfO6xRbekCzf59VeQWn1DMIrmiZzjzBvG7KfWF2lgs1JtOMkcvPBZuawqjvi
         WkZTiHb+yDoxqAakSKoJxOspnRyyCAe3tzrIyoC6QAhA6xHzRU4ZPathzIpE4q40JYim
         vk1/RzoVuK5qYQEBxegiM02YY9OoP1R4kJu6GUyaGMFUXLX0Dvs9DihOjTMVO30FwRj3
         3tottWM6z2tp6LULzqz8kl4SCKKd9jI55oHEh6i9/NCzeu8+VLMnYlL1Rwtkj9AGwpDd
         Iscks7cYmAktSxRZO1lYfN6Sqw5hOeRripcbq+s19ioS0zww3r93IQn6LQXM+PIzgZvf
         J2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=anck6fo2s+mPb68AfQbcgyo8Kx5a9s1w+YI6ylEmT2I=;
        b=FGV+K3dPgvUgCVvu/89tnTWj/t1rcvBSWmsfzNqYMVsJqwxCq6M3YYJRkOsSlGVeUf
         KXBeRv9GVCks2uSgNi+g7xk7q1D69iQx8WdmKA3w7l5fEb2fbcxiN1hMHlmgrJBVD4sW
         Iurcc84VFgPBEJI6keJ31V1FC3iR6t7QPvXwp4tEd/ZynJ1p8//h8Dpg+pfQsMjXp2Vb
         UKdplBgtJs5aYcWMvl3Oprmpp/s3XKOeGsGa24hFba9F6KD6mH2z3yroUci+o0YobGS8
         l6kUoBaZeCrelZqlaLRvyTrwyMu3gPxSLrZ8SNtM0NvtH8ETXS4ydmCtFYS92eiBPqUs
         77Vg==
X-Gm-Message-State: AOAM532jVAxarcndLW3jl4LAagvlRRfueyPzYboKacVD4N9i0EXR792p
        VDUvKDPxXIICZ5PAxdL7ueVINLQGYtwFyKOqoeQ=
X-Google-Smtp-Source: ABdhPJx2cExVVgGdOIPCqp3iITpmrIV4iw6m0bV1jTsbRf1EaepdvLw9TuHQQ271TQSdg1QmcXgAv5zXpC0g7DxzCBs=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr997405ybn.41.1627423124451;
 Tue, 27 Jul 2021 14:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com> <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com> <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com> <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
 <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com> <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
 <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com>
 <CAHw5_hnLSwMBqNxE6pPvau+-9LQoCmWp7fy6vuxtT-UPPLL4Fw@mail.gmail.com>
 <4d1f2c32-521a-aab4-7da9-6a0a8d3ecdc6@gmx.com> <CAHw5_h=izT2+AzXFK03uETYM2go=mKnSWYkW_5ki-36fkoYaNg@mail.gmail.com>
In-Reply-To: <CAHw5_h=izT2+AzXFK03uETYM2go=mKnSWYkW_5ki-36fkoYaNg@mail.gmail.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Tue, 27 Jul 2021 17:58:33 -0400
Message-ID: <CAHw5_hkP0v1YT=R2jVkjXNroibnLLV=5cMZGUMEE7BvDquASbw@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Just checking in to see if there are any other ideas or upcoming
possible fixes on the horizon.

Thanks,
Asif

On Wed, Jun 23, 2021 at 12:24 PM Asif Youssuff <yoasif@gmail.com> wrote:
>
> On Wed, Jun 23, 2021 at 5:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2021/6/23 =E4=B8=8B=E5=8D=885:32, Asif Youssuff wrote:
> > > On Tue, Jun 22, 2021 at 5:33 PM Chris Murphy <lists@colorremedies.com=
> wrote:
> > >>
> > >> On Tue, Jun 22, 2021 at 12:37 AM Asif Youssuff <yoasif@gmail.com> wr=
ote:
> > >>
> > >>> I went ahead and also created two partitions each on the two new us=
b
> > >>> disks (for a two of four new partitions) and added them to the btrf=
s
> > >>> filesystem using "btrfs device add", then removing a snapshot follo=
wed
> > >>> by a "btrfs fi sync". The filesystem still goes ro after a while.
> > >>
> > >> Yeah Qu is correct, and I had it wrong. Two devices have enough spac=
e
> > >> for a new metadata BG, but no other disks. And it requires four. All
> > >> you need is to add two but it won't even let you add one before it
> > >> goes ro. So it's stuck. Until there is a kernel fix for this, it's
> > >> permanently read-only (unless we're missing some other work around).
> > >
> > > Hmm, would this be something that would be fixed in the near term?
> > > Just wondering how long I'd have to leave this as ro.
> > >
> > > Happy to continue to try any other ideas of course, but I'd rather no=
t
> > > destroy the fs and start over.
> >
> > The problem is, I don't see why we can't do anything, including adding =
a
> > new device.
> >
> >  From the fi df output, we still have around 512M metadata free space,
> > it means unless there is something wrong with globalrsv, we should be
> > able to add new devices, which doesn't require much new space.
> >
> > For the worst case, I can craft a btrfs-progs program to manually
> > degrade all your RAID1C3/C4 chunks to SINGLE.
> >
> > By that you can have tons of space left, but that should be the last
> > thing to do IMHO.
> >
> > Currently I prefer to find a way to stop all background work like
> > balance/subvolume deletion, and try to add two new devices to the array=
,
> > then continue.
> >
> > I still can't get why "btrfs device add" would success while "btrfs fi
> > show" shows no new device.
> >
> > The new devices to add are really blank new devices, right? Not some
> > disks already used by btrfs?
>
> Yes, absolutely. I even formatted them as ext4 and rebooted in order
> to ensure that btrfs processes would not be acting on them until I did
> btrfs device add.
>
> Once I run btrfs device add, the filesystem type shows up in gparted
> as "unknown" - eg:
>
> /dev/sdk1           2048 15187967 15185920  7.2G 83 Linux
> /dev/sdk2       15187968 30375935 15187968  7.2G 83 Linux
>
> I am also adding the devices like what Paul jones suggested - like:
>
> sudo mount /media/camino/ && sudo btrfs device add -f /dev/sdl1
> /dev/sdl2 /dev/sdk1 /dev/sdk2 /media/camino/
>
> >
> > Thanks,
> > Qu
> > >
> > >>
> > >>
> > >>> Would mounting as degraded make it possible to add the disks and ha=
ve
> > >>> it stick?
> > >>
> > >> No, that's even more fragile and you're sure to run into myriad
> > >> degraded raid5 bugs, not least of which are the bogus errors. And it
> > >> won't be obvious which ones are important and which ones are not.
> > >>
> > >>
> > >> --
> > >> Chris Murphy
> > >
> > >
> > >
>
>
>
> --
> Thanks,
> Asif



--=20
Thanks,
Asif
