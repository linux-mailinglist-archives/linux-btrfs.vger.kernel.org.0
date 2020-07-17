Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D022303A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 03:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGQBLa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 21:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGQBL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 21:11:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A603BC061755
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 18:11:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p205so8517796iod.8
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 18:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkMLH5yCmd70PkhrtREND0I2GrXPqwiGbeA6ep9aPsw=;
        b=TKt6voq8i1QpnmzC2qNlNhW2G8AF5dSojuCdK+fV9VDb9s2Q88JCPtp4A+TRu/ko3S
         8w6xM27udBPeYt4CBQ1vb4h30Pyz8L2bsm4Sqb3WZzUKcOxEJrjExfhT8GOHx+3VWZEm
         rditJbdd2pS29xTwL0TfEOb5ExA90kxfbQztDR85vqoCBR/AqUB9OVRJIXPM2/TK4BQc
         1meRUR1z32GzfQAuanDTkaJDkliWJI/LtYGFbNVKtwS4vYxKT6rHDW820yYBdAqwqBWU
         97XaJexdZbBwmVtWXAKQJI/RHsy+PGY39Q8Gch6Bsjr5Rz/JxWZ62Ibdmv4KhvepJ83O
         Q/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkMLH5yCmd70PkhrtREND0I2GrXPqwiGbeA6ep9aPsw=;
        b=fZVGhVqw34hZBfcD/+eC9FjUuL9kZ03YeVxEhC3codRH6+i8EomoTxz6QJgVp/ojTF
         hCnypIMEvyT/TKUjiIAGlDw7n6v1VZkzq/ep87UgT2SZx1Sk21O9LK/zD6FzeF95QMgN
         za5ZLzZ9S/JKic4fok57cKZa4yWzL+loVF8PS7+00oeAVfXduLKJZzi4mNtkk6JziNCH
         r9LqCB7x26Lsniw6qlNd8eISSdqCVnQVVf5g06z2F2kdv10IBlwwMaXTudDrKL+Rhd4O
         v/izRoW5LoF1+Ege0bXLRrjQLqDJXq5uhoHcc4iyrZcaQjIvxGhzrrTan3mQUDtTFsTl
         HZnQ==
X-Gm-Message-State: AOAM532QgOocdCBO4Psgfpg0uDu17VP8akUmlsvpf2BaIv83ZLaCtkWE
        96vs5THVggIxfpxhIELpdkbUtJKn2SGptwU1vx0=
X-Google-Smtp-Source: ABdhPJwK72HA1AxJXBVZ8TstwCXAnBvEe63bwo0N2AdgnNHK+RN5A0XiPCXkj5Hy83FXKFiahVz8T9jFGVcMVB729LY=
X-Received: by 2002:a05:6e02:f42:: with SMTP id y2mr7477863ilj.264.1594948288650;
 Thu, 16 Jul 2020 18:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
 <20200715011843.GH10769@hungrycats.org> <CADvYWxcq+-Fg0W9dmc-shwszF-7sX+GDVig0GncpvwKUDPfT7g@mail.gmail.com>
 <20200716042739.GB8346@hungrycats.org> <CADvYWxdvy5n3Tsa+MG9sSB2iAu-eA+W33ApzQ3q9D6sdGR9UYA@mail.gmail.com>
 <CAJix6J9kmQjfFJJ1GwWXsX7WW6QKxPqpKx86g7hgA4PfbH5Rpg@mail.gmail.com> <20200716225731.GI10769@hungrycats.org>
In-Reply-To: <20200716225731.GI10769@hungrycats.org>
From:   John Petrini <john.d.petrini@gmail.com>
Date:   Thu, 16 Jul 2020 21:11:17 -0400
Message-ID: <CADvYWxcMCEvOg8C-gbGRC1d02Z6TCypvsan7mi+8U2PVKwfRwQ@mail.gmail.com>
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data Conversion
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     John Petrini <me@johnpetrini.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 16, 2020 at 6:57 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Thu, Jul 16, 2020 at 10:20:43AM -0400, John Petrini wrote:
> >    I've cleaned up a bit more space and kicked off a balance. btrfs fi usage
> >    is reporting increased unallocated space so it seems to be helping.
> >    sudo btrfs balance start -dusage=50 /mnt/storage-array/
> >    During one of my attempts to clean up space the filesystem went read only
> >    again with the same out of space error. I'm curious why deleting files
> >    would cause this.
>
> Deleting a file requires writing a new tree with the file not present.
> That requires some extra space...
>
> >    On Thu, Jul 16, 2020 at 9:38 AM John Petrini <[1]john.d.petrini@gmail.com>
> >    wrote:
> >
> >      On Thu, Jul 16, 2020 at 12:27 AM Zygo Blaxell
> >      <[2]ce3g8jdj@umail.furryterror.org> wrote:
> >      >
> >      > On Tue, Jul 14, 2020 at 10:49:08PM -0400, John Petrini wrote:
> >      > > I've done this and the filesystem mounted successfully though when
> >      > > attempting to cancel the balance it just tells me it's not running.
> >      >
> >      > That's fine, as long as it stops one way or another.
> >      >
> >      > > > Aside:  data-raid6 metadata-raid10 isn't a sane configuration.  It
> >      > > > has 2 redundant disks for data and 1 redundant disk for metadata,
> >      so
> >      > > > the second parity disk in raid6 is wasted space.
> >      > > >
> >      > > > The sane configurations for parity raid are:
> >      > > >
> >      > > >         data-raid6 metadata-raid1c3 (2 parity stripes for data, 3
> >      copies
> >      > > >         for metadata, 2 disks can fail, requires 3 or more disks)
> >      > > >
> >      > > >         data-raid5 metadata-raid10 (1 parity stripe for data, 2
> >      copies
> >      > > >         for metadata, 1 disk can fail, requires 4 or more disks)
> >      > > >
> >      > > >         data-raid5 metadata-raid1 (1 parity stripe for data, 2
> >      copies
> >      > > >         for metadata, 1 disk can fail, requires 2 or more disks)
> >      > > >
> >      > >
> >      > > This is very interesting. I had no idea that raid1c3 was an option
> >      > > though it sounds like I may need a really recent kernel version?
> >      >
> >      > 5.5 or later.
> >
> >      Okay I'll look into getting on this version since that's a killer
> >      feature.
> >
> >      >
> >      > > btrfs fi usage /mnt/storage-array/
> >      > > WARNING: RAID56 detected, not implemented
> >      > > Overall:
> >      > >     Device size:          67.31TiB
> >      > >     Device allocated:          65.45TiB
> >      > >     Device unallocated:           1.86TiB
> >      > >     Device missing:             0.00B
> >      > >     Used:              65.14TiB
> >      > >     Free (estimated):           1.12TiB    (min: 1.09TiB)
> >      > >     Data ratio:                  1.94
> >      > >     Metadata ratio:              2.00
> >      > >     Global reserve:         512.00MiB    (used: 0.00B)
> >      > >
> >      > > Data,RAID10: Size:32.68TiB, Used:32.53TiB
> >      > >    /dev/sda       4.34TiB
> >      > >    /dev/sdb       4.34TiB
> >      > >    /dev/sdc       4.34TiB
> >      > >    /dev/sdd       2.21TiB
> >      > >    /dev/sde       2.21TiB
> >      > >    /dev/sdf       4.34TiB
> >      > >    /dev/sdi       1.82TiB
> >      > >    /dev/sdj       1.82TiB
> >      > >    /dev/sdk       1.82TiB
> >      > >    /dev/sdl       1.82TiB
> >      > >    /dev/sdm       1.82TiB
> >      > >    /dev/sdn       1.82TiB
> >      > >
> >      > > Data,RAID6: Size:1.04TiB, Used:1.04TiB
> >      > >    /dev/sda     413.92GiB
> >      > >    /dev/sdb     413.92GiB
> >      > >    /dev/sdc     413.92GiB
> >      > >    /dev/sdd     119.07GiB
> >      > >    /dev/sde     119.07GiB
> >      > >    /dev/sdf     413.92GiB
> >      > >
> >      > > Metadata,RAID10: Size:40.84GiB, Used:39.80GiB
> >      > >    /dev/sda       5.66GiB
> >      > >    /dev/sdb       5.66GiB
> >      > >    /dev/sdc       5.66GiB
> >      > >    /dev/sdd       2.41GiB
> >      > >    /dev/sde       2.41GiB
> >      > >    /dev/sdf       5.66GiB
> >      > >    /dev/sdi       2.23GiB
> >      > >    /dev/sdj       2.23GiB
> >      > >    /dev/sdk       2.23GiB
> >      > >    /dev/sdl       2.23GiB
> >      > >    /dev/sdm       2.23GiB
> >      > >    /dev/sdn       2.23GiB
> >      > >
> >      > > System,RAID10: Size:96.00MiB, Used:3.06MiB
> >      > >    /dev/sda       8.00MiB
> >      > >    /dev/sdb       8.00MiB
> >      > >    /dev/sdc       8.00MiB
> >      > >    /dev/sdd       8.00MiB
> >      > >    /dev/sde       8.00MiB
> >      > >    /dev/sdf       8.00MiB
> >      > >    /dev/sdi       8.00MiB
> >      > >    /dev/sdj       8.00MiB
> >      > >    /dev/sdk       8.00MiB
> >      > >    /dev/sdl       8.00MiB
> >      > >    /dev/sdm       8.00MiB
> >      > >    /dev/sdn       8.00MiB
> >      > >
> >      > > Unallocated:
> >      > >    /dev/sda       4.35TiB
> >      > >    /dev/sdb       4.35TiB
> >      > >    /dev/sdc       4.35TiB
> >      > >    /dev/sdd       2.22TiB
> >      > >    /dev/sde       2.22TiB
> >      > >    /dev/sdf       4.35TiB
> >      > >    /dev/sdi       1.82TiB
> >      > >    /dev/sdj       1.82TiB
> >      > >    /dev/sdk       1.82TiB
> >      > >    /dev/sdl       1.82TiB
> >      > >    /dev/sdm       1.82TiB
> >      > >    /dev/sdn       1.82TiB
> >      >
> >      > Plenty of unallocated space.  It should be able to do the conversion.
> >
> >      After upgrading, the unallocated space tells a different story. Maybe
> >      due to the newer kernel or btrfs-progs?
>
> That is...odd.  Try 'btrfs dev usage', maybe something weird is happening
> with device sizes.

Here it is. I'm not sure what to make of it though.

sudo btrfs dev usage /mnt/storage-array/
/dev/sdd, ID: 1
   Device size:             4.55TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             2.78GiB
   Data,RAID10:           784.31GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            144.07GiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Metadata,RAID10:       352.00MiB
   Unallocated:             1.02MiB

/dev/sde, ID: 2
   Device size:             4.55TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             2.78GiB
   Data,RAID10:           784.31GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            144.07GiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Metadata,RAID10:       352.00MiB
   Unallocated:             1.02MiB

/dev/sdl, ID: 3
   Device size:             3.64TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Unallocated:             1.02MiB

/dev/sdn, ID: 4
   Device size:             3.64TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Unallocated:             1.02MiB

/dev/sdm, ID: 5
   Device size:             3.64TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Unallocated:             1.02MiB

/dev/sdk, ID: 6
   Device size:             3.64TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Unallocated:             1.02MiB

/dev/sdj, ID: 7
   Device size:             3.64TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Unallocated:             1.02MiB

/dev/sdi, ID: 8
   Device size:             3.64TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Unallocated:             1.02MiB

/dev/sdb, ID: 9
   Device size:             9.10TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             4.01TiB
   Data,RAID10:           784.31GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            458.56GiB
   Data,RAID6:            144.07GiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Metadata,RAID10:       352.00MiB
   Metadata,RAID10:         6.00GiB
   Metadata,RAID1C3:        2.00GiB
   System,RAID1C3:         32.00MiB
   Unallocated:            82.89GiB

/dev/sdc, ID: 10
   Device size:             9.10TiB
   Device slack:              0.00B
   Data,RAID10:             3.12GiB
   Data,RAID10:             4.01TiB
   Data,RAID10:           784.31GiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            458.56GiB
   Data,RAID6:            144.07GiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Metadata,RAID10:       352.00MiB
   Metadata,RAID10:         6.00GiB
   Metadata,RAID1C3:        3.00GiB
   Unallocated:            81.92GiB

/dev/sda, ID: 11
   Device size:             9.10TiB
   Device slack:              0.00B
   Data,RAID10:           784.31GiB
   Data,RAID10:             4.01TiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            458.56GiB
   Data,RAID6:            144.07GiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Metadata,RAID10:       352.00MiB
   Metadata,RAID10:         6.00GiB
   Metadata,RAID1C3:        5.00GiB
   System,RAID1C3:         32.00MiB
   Unallocated:            85.79GiB

/dev/sdf, ID: 12
   Device size:             9.10TiB
   Device slack:              0.00B
   Data,RAID10:           784.31GiB
   Data,RAID10:             4.01TiB
   Data,RAID10:             3.34TiB
   Data,RAID6:            458.56GiB
   Data,RAID6:            144.07GiB
   Data,RAID6:            293.03GiB
   Metadata,RAID10:         4.47GiB
   Metadata,RAID10:       352.00MiB
   Metadata,RAID10:         6.00GiB
   Metadata,RAID1C3:        5.00GiB
   System,RAID1C3:         32.00MiB
   Unallocated:            85.79GiB

>
> >      Unallocated:
> >         /dev/sdd        1.02MiB
> >         /dev/sde        1.02MiB
> >         /dev/sdl        1.02MiB
> >         /dev/sdn        1.02MiB
> >         /dev/sdm        1.02MiB
> >         /dev/sdk        1.02MiB
> >         /dev/sdj        1.02MiB
> >         /dev/sdi        1.02MiB
> >         /dev/sdb        1.00MiB
> >         /dev/sdc        1.00MiB
> >         /dev/sda        5.90GiB
> >         /dev/sdg        5.90GiB
>
> ...and here we have only 2 disks with free space, so there's zero available
> space for more metadata (raid10 requires 4 disks).
>
> >      This is after clearing up additional space on the filesytem. When I
> >      started the conversion there was only ~300G available. There's now
> >      close 1TB according to df.
> >
> >      /dev/sdd                      68T   66T  932G  99% /mnt/storage-array
> >
> >      So I'm not sure what to make of this and whether it's safe to start
> >      the conversion again. I don't feel like I can trust the unallocated
> >      space before or after the upgrade.
> >
> >      Here's the versions I'm on now:
> >      sudo dpkg -l | grep btrfs-progs
> >      ii  btrfs-progs                            5.4.1-2
> >              amd64        Checksumming Copy on Write Filesystem utilities
> >
> >      uname -r
> >      5.4.0-40-generic
> >
> >      >
> >      > > > You didn't post the dmesg messages from when the filesystem went
> >      > > > read-only, but metadata 'total' is very close to 'used', you were
> >      doing
> >      > > > a balance, and the filesystem went read-only, so I'm guessing you
> >      hit
> >      > > > ENOSPC for metadata due to lack of unallocated space on at least 4
> >      drives
> >      > > > (minimum for raid10).
> >      > > >
> >      > >
> >      > > Here's a paste of everything in dmesg:
> >      [3]http://paste.openstack.org/show/795929/
> >      >
> >      > Unfortunately the original errors are no longer in the buffer.  Maybe
> >      > try /var/log/kern.log?
> >      >
> >
> >      Found it. So this was a space issue. I knew the filesystem was very
> >      full but figured ~300G would be enough.
> >
> >      kernel: [3755232.352221] BTRFS: error (device sdd) in
> >      __btrfs_free_extent:4860: errno=-28 No space left
> >      kernel: [3755232.352227] BTRFS: Transaction aborted (error -28)
> >      ernel: [3755232.354693] BTRFS info (device sdd): forced readonly
> >      kernel: [3755232.354700] BTRFS: error (device sdd) in
> >      btrfs_run_delayed_refs:2795: errno=-28 No space left
>
> The trick is that the free space has to be unallocated to change profiles.
> 'df' counts both unallocated and allocated-but-unused space.
>
> Also you have disks of different sizes, which adds an additional
> complication: raid6 data on 3 disks takes up more space for the same data
> than raid10 data on 4 disks, because the former is 1 data + 2 parity,
> while the latter is 1 data + 1 mirror.  So for 100 GB of data, it's 200
> GB of raw space in raid10 on 4 disks, or 200GB of raw space in raid6 on
> 4 disks, but 300 GB of raw space in raid6 on 3 disks.
>
> Since your filesystem is nearly full, there are likely to be 3-disk-wide
> raid6 block groups formed when there is space available on only 3 drives.
> If that happens too often, hundreds of GB will be wasted and the filesystem
> fills up.
>
> To convert raid10 to raid6 on a full filesystem with unequal disk sizes
> you'll need to do a few steps:
>
>         1.  balance -dconvert=raid1,stripes=1..3,profiles=raid6
>
> This converts any 3-stripe raid6 to raid1, which will get some wasted
> space back.  Use raid1 here because it's more flexible for allocation
> on small numbers of disks than raid10.  We will get rid of it later.
>
>         2.  balance -dconvert=raid1,devid=1,limit=5
>             balance -dconvert=raid1,devid=2,limit=5
>             balance -dconvert=raid1,devid=3,limit=5
>             balance -dconvert=raid1,devid=6,limit=5
>
> Use btrfs fi show to see the real devids for these, I just put sequential
> numbers in the above.
>
> These balances relocate data on the 4.34TB drives to other disks in
> the array.  The goal is to get some unallocated space on all of the
> largest disks so you can create raid6 block groups that span all of them.
>
> We convert to raid1 to get more flexible redistribution of the
> space--raid10 will keep trying to fill every available drive, and has
> a 4-disk minimum, while raid1 will try to equally distribute space on
> all drives but only 2 at a time.  'soft' is not used here because we
> want to relocate block groups on these devices whether they are already
> raid1 or not.
>
> Note that if there is 5GB free on all the largest disks we can skip
> this entire step.  If there is not 5GB free on all the largest disks
> at the end of the above commands, you may need to repeat this step,
> or try 'balance -dconvert=raid1,limit=50' to try to force free space
> on all disks in the array.
>
>         3.  balance -dconvert=raid6,soft,devid=1
>
> This converts all data block groups that have at least one chunk on devid
> 1 (or any disk of the largest size in the array) from raid10 to raid6.
> This will ensure that every chunk that is added to devid 1 has at least
> one corresponding chunk that is removed from devid 1.  That way, devid
> 1 doesn't fill up; instead, it will stay with a few GB unallocated.
> The other disks will get unallocated space because a raid6 block group
> that is at least 4 disks wide will store more data in the same raw space
> than raid10.
>
> At this stage it doesn't matter where the space is coming from, as long as
> it's coming from a minimum of 4 other disks, and not filling up devid 1.
> Some block groups will not be optimal.  We'll optimize later.
>
> Eventually you'll get to the point where there is unallocated space on
> all disks, and then the balance will finish converting the data to raid6
> without further attention.
>
>         4.  balance -dstripes=1..3,devid=1  # sda, 4.34TB
>             balance -dstripes=1..3,devid=2  # sdb, 4.34TB
>             balance -dstripes=1..3,devid=3  # sdc, 4.34TB
>             balance -dstripes=1..5,devid=4  # sdd, 2.21TB
>             balance -dstripes=1..5,devid=5  # sde, 2.21TB
>             balance -dstripes=1..3,devid=6  # sdf, 4.34TB
>             balance -dstripes=1..9,devid=7  # sdg, 1.82TB
>             balance -dstripes=1..9,devid=8  # sdh, 1.82TB
>             balance -dstripes=1..9,devid=9  # sdi, 1.82TB
>             balance -dstripes=1..9,devid=10 # sdj, 1.82TB
>
> This rebalances any narrow stripes that may have formed during the
> previous balances.  For each device we calculate how many disks are
> the same or equal size, and rebalance any block group that is not
> that number of disks wide:
>
>         There are 4 4.34TB disks, so we balance any block group
>         on a 4.34TB disk that is 1 to (4-1) = 3 stripes wide.
>
>         There are 6 2.21TB-or-larger disks (2x2.21TB + 4x4.34TB), so we
>         balance any block group on a 2.21TB disk that is 1 to (6-1) =
>         5 stripes wide.
>
>         There are 10 1.82TB-or-larger disks (this is the smallest size
>         disk, so all 10 disks are equal or larger), so we balance any
>         block group on a 1.82TB disk that is 1 to (10-1) = 9 stripes wide.
>
> These balances will only relocate non-optimal block groups, so each one
> should not relocate many block groups.  If 'btrfs balance status -v' says
> it's relocating thousands of block groups, check the stripe count and
> devid--if you use the wrong stripe count it will unnecessarily relocate
> all the data on the device.
>
>         5.  balance -mconvert=raid1c3,soft
>
> The final step converts metadata from raid10 to raid1c3.  (requires
> kernel 5.5)

Wow looks like I've got lots of info to mull over here! I kicked off
another convert already after cleaning up quite a bit more space. I
had over 100G unallocated on each device after deleting some data and
running another balance. I'm tempted to let it run and see if it
succeeds but my unallocated space has already dropped off a cliff with
95% of the rebalance remaining.

The command I used was: btrfs fi balance start -dconvert=raid6,soft
-mconvert=raid1c3 /mnt/storage-array/

Here's the current unallocated with only 5% of the conversion complete.
Unallocated:
   /dev/sdd        1.02MiB
   /dev/sde        1.02MiB
   /dev/sdl        1.02MiB
   /dev/sdn        1.02MiB
   /dev/sdm        1.02MiB
   /dev/sdk        1.02MiB
   /dev/sdj        1.02MiB
   /dev/sdi        1.02MiB
   /dev/sdb       82.89GiB
   /dev/sdc       81.92GiB
   /dev/sda       85.79GiB
   /dev/sdf       85.79GiB

>
>
>
> >      > > > > uname -r
> >      > > > > 5.3.0-40-generic
> >      > > >
> >      > > > Please upgrade to 5.4.13 or later.  Kernels 5.1 through 5.4.12
> >      have a
> >      > > > rare but nasty bug that is triggered by writing at exactly the
> >      wrong
> >      > > > moment during balance.  5.3 has some internal defenses against
> >      that bug
> >      > > > (the "write time tree checker"), but if they fail, the result is
> >      metadata
> >      > > > corruption that requires btrfs check to repair.
> >      > > >
> >      > >
> >      > > Thanks for the heads up. I'm getting it updated now and will attempt
> >      > > to remount once I do. Once it's remounted how should I proceed? Can
> >      I
> >      > > just assume the filesystem is healthy at that point? Should I
> >      perform
> >      > > a scrub?
> >      >
> >      > If scrub reports no errors it's probably OK.
> >
> >      I did run a scrub and it came back clean.
> >
> >      >
> >      > A scrub will tell you if any data or metadata is corrupted or any
> >      > parent-child pointers are broken.  That will cover most of the common
> >      > problems.  If the original issue was a spurious ENOSPC then everything
> >      > should be OK.  If the original issue was a write time tree corruption
> >      > then it should be OK.  If the original issue was something else, it
> >      > will present itself again during the scrub or balance.
> >      >
> >      > If there are errors, scrub won't attribute them to the right disks for
> >      > raid6.  It might be worth reading
> >      >
> >      >
> >       [4]https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/
> >      >
> >      > for a list of current raid5/6 issues to be aware of.
> >
> >      Thanks. This is good info.
> >
> >    --
> >    John Petrini
> >
> > References
> >
> >    Visible links
> >    1. mailto:john.d.petrini@gmail.com
> >    2. mailto:ce3g8jdj@umail.furryterror.org
> >    3. http://paste.openstack.org/show/795929/
> >    4. https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/



-- 
---------------------------------------
John Petrini
