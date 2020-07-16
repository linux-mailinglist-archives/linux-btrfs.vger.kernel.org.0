Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2522240D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGPNhm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGPNhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 09:37:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1ABC061755
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 06:37:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i4so5978060iov.11
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BTLw7sfYPG1UtP32ySYlabkh2AUEBWoUxJKl0uFFvFA=;
        b=uqQ8LFb920Yz6O6gtFY+KBziD9zvsdlQH+eIBvpEvXdGPu0WIjJLjaJYj03zGQt11p
         OVY3d3XK/Ok/+YIjBFEmVRwRmMGygxytWIkXuc/Q116ZgcOG7NId9SilMJyyTpmc3sZl
         QAnTUEoDcv0nzASJDV2t8hCe1/i0aJKquSIfiV824OAJCoQheIc7wlkrmw+ZJW802RM/
         1kxac5SDkKgG9Fo+uDhEO6D0jFaX6ojtp8o2CXwIUp9SCwNXDlcwZPBi2NZh1xbi4iTL
         RIibkmmBmw0gUBxPW1Shcrmt6U49icYHyH44Q/LXFGdk+80Oe1mC3GinGQ8LAbwt1eN5
         kuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BTLw7sfYPG1UtP32ySYlabkh2AUEBWoUxJKl0uFFvFA=;
        b=oOQyn94F7/CQzteaCMWk1cAVq9qz+ppkoBnHS4JEbvBtk6ZtCawLADajrr0B90J/vE
         ERJXodUWJrdprtDHZD2IQvOFrgq4+TVgJIIWo2khmsAepUh+u0dXo64Z/hHHUFYWOvIU
         obRrTDt33PZLbgBCLjLRq5T/d99nF57SnkpnLhuzLPfX1nk1xu6UNxaSCr+WlvpdCLkJ
         EwL7PB0+e1JyKRHLcoAgOVLGKRZI6hxTVNDMzMfT70Db2R4Qat+3N8/VHkPYVyxBchKq
         AhkJ4vNxHXiseiWQvy3+dwWR1nLPiQm4M9OkBxHDQ+wMvO/NwZumBkemkBg/u/F7SmIf
         rCRg==
X-Gm-Message-State: AOAM531RVSFoZAcfM3V+NCYx6Ds0J6mZHUxB9/iuw9BcbH8afFkda60w
        K7R1ludNKugz7JJPYt4CeOzRpCOxjd84hkoyWzJSMS5Azb8=
X-Google-Smtp-Source: ABdhPJwRoUu3gwMR/Kw3aqIPZClMz+XZF9JcJ263tA1dX/YsK9Ao0FikRw5YibmmxxMvBYnKmv1wqs6ZM2nfB6qJ5MI=
X-Received: by 2002:a6b:9354:: with SMTP id v81mr1366767iod.30.1594906660373;
 Thu, 16 Jul 2020 06:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
 <20200715011843.GH10769@hungrycats.org> <CADvYWxcq+-Fg0W9dmc-shwszF-7sX+GDVig0GncpvwKUDPfT7g@mail.gmail.com>
 <20200716042739.GB8346@hungrycats.org>
In-Reply-To: <20200716042739.GB8346@hungrycats.org>
From:   John Petrini <john.d.petrini@gmail.com>
Date:   Thu, 16 Jul 2020 09:37:29 -0400
Message-ID: <CADvYWxdvy5n3Tsa+MG9sSB2iAu-eA+W33ApzQ3q9D6sdGR9UYA@mail.gmail.com>
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data Conversion
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 16, 2020 at 12:27 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Tue, Jul 14, 2020 at 10:49:08PM -0400, John Petrini wrote:
> > I've done this and the filesystem mounted successfully though when
> > attempting to cancel the balance it just tells me it's not running.
>
> That's fine, as long as it stops one way or another.
>
> > > Aside:  data-raid6 metadata-raid10 isn't a sane configuration.  It
> > > has 2 redundant disks for data and 1 redundant disk for metadata, so
> > > the second parity disk in raid6 is wasted space.
> > >
> > > The sane configurations for parity raid are:
> > >
> > >         data-raid6 metadata-raid1c3 (2 parity stripes for data, 3 copies
> > >         for metadata, 2 disks can fail, requires 3 or more disks)
> > >
> > >         data-raid5 metadata-raid10 (1 parity stripe for data, 2 copies
> > >         for metadata, 1 disk can fail, requires 4 or more disks)
> > >
> > >         data-raid5 metadata-raid1 (1 parity stripe for data, 2 copies
> > >         for metadata, 1 disk can fail, requires 2 or more disks)
> > >
> >
> > This is very interesting. I had no idea that raid1c3 was an option
> > though it sounds like I may need a really recent kernel version?
>
> 5.5 or later.

Okay I'll look into getting on this version since that's a killer feature.

>
> > btrfs fi usage /mnt/storage-array/
> > WARNING: RAID56 detected, not implemented
> > Overall:
> >     Device size:          67.31TiB
> >     Device allocated:          65.45TiB
> >     Device unallocated:           1.86TiB
> >     Device missing:             0.00B
> >     Used:              65.14TiB
> >     Free (estimated):           1.12TiB    (min: 1.09TiB)
> >     Data ratio:                  1.94
> >     Metadata ratio:              2.00
> >     Global reserve:         512.00MiB    (used: 0.00B)
> >
> > Data,RAID10: Size:32.68TiB, Used:32.53TiB
> >    /dev/sda       4.34TiB
> >    /dev/sdb       4.34TiB
> >    /dev/sdc       4.34TiB
> >    /dev/sdd       2.21TiB
> >    /dev/sde       2.21TiB
> >    /dev/sdf       4.34TiB
> >    /dev/sdi       1.82TiB
> >    /dev/sdj       1.82TiB
> >    /dev/sdk       1.82TiB
> >    /dev/sdl       1.82TiB
> >    /dev/sdm       1.82TiB
> >    /dev/sdn       1.82TiB
> >
> > Data,RAID6: Size:1.04TiB, Used:1.04TiB
> >    /dev/sda     413.92GiB
> >    /dev/sdb     413.92GiB
> >    /dev/sdc     413.92GiB
> >    /dev/sdd     119.07GiB
> >    /dev/sde     119.07GiB
> >    /dev/sdf     413.92GiB
> >
> > Metadata,RAID10: Size:40.84GiB, Used:39.80GiB
> >    /dev/sda       5.66GiB
> >    /dev/sdb       5.66GiB
> >    /dev/sdc       5.66GiB
> >    /dev/sdd       2.41GiB
> >    /dev/sde       2.41GiB
> >    /dev/sdf       5.66GiB
> >    /dev/sdi       2.23GiB
> >    /dev/sdj       2.23GiB
> >    /dev/sdk       2.23GiB
> >    /dev/sdl       2.23GiB
> >    /dev/sdm       2.23GiB
> >    /dev/sdn       2.23GiB
> >
> > System,RAID10: Size:96.00MiB, Used:3.06MiB
> >    /dev/sda       8.00MiB
> >    /dev/sdb       8.00MiB
> >    /dev/sdc       8.00MiB
> >    /dev/sdd       8.00MiB
> >    /dev/sde       8.00MiB
> >    /dev/sdf       8.00MiB
> >    /dev/sdi       8.00MiB
> >    /dev/sdj       8.00MiB
> >    /dev/sdk       8.00MiB
> >    /dev/sdl       8.00MiB
> >    /dev/sdm       8.00MiB
> >    /dev/sdn       8.00MiB
> >
> > Unallocated:
> >    /dev/sda       4.35TiB
> >    /dev/sdb       4.35TiB
> >    /dev/sdc       4.35TiB
> >    /dev/sdd       2.22TiB
> >    /dev/sde       2.22TiB
> >    /dev/sdf       4.35TiB
> >    /dev/sdi       1.82TiB
> >    /dev/sdj       1.82TiB
> >    /dev/sdk       1.82TiB
> >    /dev/sdl       1.82TiB
> >    /dev/sdm       1.82TiB
> >    /dev/sdn       1.82TiB
>
> Plenty of unallocated space.  It should be able to do the conversion.

After upgrading, the unallocated space tells a different story. Maybe
due to the newer kernel or btrfs-progs?

Unallocated:
   /dev/sdd        1.02MiB
   /dev/sde        1.02MiB
   /dev/sdl        1.02MiB
   /dev/sdn        1.02MiB
   /dev/sdm        1.02MiB
   /dev/sdk        1.02MiB
   /dev/sdj        1.02MiB
   /dev/sdi        1.02MiB
   /dev/sdb        1.00MiB
   /dev/sdc        1.00MiB
   /dev/sda        5.90GiB
   /dev/sdg        5.90GiB

This is after clearing up additional space on the filesytem. When I
started the conversion there was only ~300G available. There's now
close 1TB according to df.

/dev/sdd                      68T   66T  932G  99% /mnt/storage-array

So I'm not sure what to make of this and whether it's safe to start
the conversion again. I don't feel like I can trust the unallocated
space before or after the upgrade.


Here's the versions I'm on now:
sudo dpkg -l | grep btrfs-progs
ii  btrfs-progs                            5.4.1-2
        amd64        Checksumming Copy on Write Filesystem utilities

uname -r
5.4.0-40-generic

>
> > > You didn't post the dmesg messages from when the filesystem went
> > > read-only, but metadata 'total' is very close to 'used', you were doing
> > > a balance, and the filesystem went read-only, so I'm guessing you hit
> > > ENOSPC for metadata due to lack of unallocated space on at least 4 drives
> > > (minimum for raid10).
> > >
> >
> > Here's a paste of everything in dmesg: http://paste.openstack.org/show/795929/
>
> Unfortunately the original errors are no longer in the buffer.  Maybe
> try /var/log/kern.log?
>

Found it. So this was a space issue. I knew the filesystem was very
full but figured ~300G would be enough.

kernel: [3755232.352221] BTRFS: error (device sdd) in
__btrfs_free_extent:4860: errno=-28 No space left
kernel: [3755232.352227] BTRFS: Transaction aborted (error -28)
ernel: [3755232.354693] BTRFS info (device sdd): forced readonly
kernel: [3755232.354700] BTRFS: error (device sdd) in
btrfs_run_delayed_refs:2795: errno=-28 No space left


> > > > uname -r
> > > > 5.3.0-40-generic
> > >
> > > Please upgrade to 5.4.13 or later.  Kernels 5.1 through 5.4.12 have a
> > > rare but nasty bug that is triggered by writing at exactly the wrong
> > > moment during balance.  5.3 has some internal defenses against that bug
> > > (the "write time tree checker"), but if they fail, the result is metadata
> > > corruption that requires btrfs check to repair.
> > >
> >
> > Thanks for the heads up. I'm getting it updated now and will attempt
> > to remount once I do. Once it's remounted how should I proceed? Can I
> > just assume the filesystem is healthy at that point? Should I perform
> > a scrub?
>
> If scrub reports no errors it's probably OK.

I did run a scrub and it came back clean.

>
> A scrub will tell you if any data or metadata is corrupted or any
> parent-child pointers are broken.  That will cover most of the common
> problems.  If the original issue was a spurious ENOSPC then everything
> should be OK.  If the original issue was a write time tree corruption
> then it should be OK.  If the original issue was something else, it
> will present itself again during the scrub or balance.
>
> If there are errors, scrub won't attribute them to the right disks for
> raid6.  It might be worth reading
>
>         https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/
>
> for a list of current raid5/6 issues to be aware of.

Thanks. This is good info.
