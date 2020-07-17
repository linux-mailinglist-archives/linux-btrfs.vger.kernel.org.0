Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0031224677
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jul 2020 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgGQWyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 18:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQWyZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 18:54:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C0C0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 15:54:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h16so8654433ilj.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JBFqp4jPOmCUHraFwJBecmfC0jZdjxe0+fZcyqVu6I=;
        b=LNuf1petaivUmv7ko3Ie+XXw9s8139Y8CiBgck8EMzdVas/mT4xzlA2IRNIOLbHxB5
         kaglTBkxH/u95vO93MdCPCdqowwqiNYEtSdXBbl1DlfWS/3AyUA3dZW+W9dkjpPUnemy
         ajoE0ulNJIDPpulmoVnV9W+H4oHHwohnM3SakxUz3GLWEYBc8jNzQOuSeUWeU9lHlBpd
         i64A2voVWxaU9COGslXn7WtNyNZpVqLjVBMFKA46N/PvCpfcUrkqJ5qJl1yU/BXMoG1d
         8Hv5LhkKOaL24vwBsvTIqpKgLsNpqZ96t25SXbMGQf91zJXrIpU0bY2SmASmZMRbnYxf
         Q8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JBFqp4jPOmCUHraFwJBecmfC0jZdjxe0+fZcyqVu6I=;
        b=dObY97VRy2tiPmaEWKGRCI6qcOtkgFHYHw27vbi6vK/TLG56bLF8plpUaFhZnKMVF8
         MLHxSTPc8ObsZkBejOOrlkjqSXGudlmZrnzsoYr7pJDCP4Hhb5BMh1m8wzN470bG4Xrq
         RfwAXWAlhLDzurnZ3q1VPjUxMLISsrzSIly+8Mo1Lsg7+D1O5Vr9LCvLEURxgojb6sIT
         KkAsv/7qilSzLjNV6CCzBBEAbgJQ9uDQsVY8zsy0VH69KwegNfcT53ojHBsc0ipXcYOx
         3xpJ6Cd2dMPjTULSJIMfdWkhFEJzldwLUYoFN4GUKop6KRskoFGZLTHTwvFw0KLcDJXP
         6tkg==
X-Gm-Message-State: AOAM532ZpL4F9ugmx0O7535Opf8szv+roTcboGKEq4bIHwrVIkvE8oQx
        Jag8d05p1Z9Q5MLVQkND0zjy8v88CFklWKTFQAY=
X-Google-Smtp-Source: ABdhPJxaacvrtYDtJE2uppvpBJjXu7bIIrzJJ5M0E1dsneG/K+zfABHnW35IRqtwSH74IvA7kDLszfILiGg54FhhNv0=
X-Received: by 2002:a92:aa92:: with SMTP id p18mr11919804ill.199.1595026463982;
 Fri, 17 Jul 2020 15:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
 <20200715011843.GH10769@hungrycats.org> <CADvYWxcq+-Fg0W9dmc-shwszF-7sX+GDVig0GncpvwKUDPfT7g@mail.gmail.com>
 <20200716042739.GB8346@hungrycats.org> <CADvYWxdvy5n3Tsa+MG9sSB2iAu-eA+W33ApzQ3q9D6sdGR9UYA@mail.gmail.com>
 <CAJix6J9kmQjfFJJ1GwWXsX7WW6QKxPqpKx86g7hgA4PfbH5Rpg@mail.gmail.com>
 <20200716225731.GI10769@hungrycats.org> <CADvYWxcMCEvOg8C-gbGRC1d02Z6TCypvsan7mi+8U2PVKwfRwQ@mail.gmail.com>
 <20200717055706.GJ10769@hungrycats.org>
In-Reply-To: <20200717055706.GJ10769@hungrycats.org>
From:   John Petrini <john.d.petrini@gmail.com>
Date:   Fri, 17 Jul 2020 18:54:12 -0400
Message-ID: <CADvYWxeP83uQ7VHQ6y+_3yyRKnNVGBWBRsPSqBG_wHfjkeCFog@mail.gmail.com>
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data Conversion
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     John Petrini <me@johnpetrini.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 17, 2020 at 1:57 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Thu, Jul 16, 2020 at 09:11:17PM -0400, John Petrini wrote:
> > On Thu, Jul 16, 2020 at 6:57 PM Zygo Blaxell
> > > That is...odd.  Try 'btrfs dev usage', maybe something weird is happening
> > > with device sizes.
> >
> > Here it is. I'm not sure what to make of it though.
> >
> > sudo btrfs dev usage /mnt/storage-array/
> > /dev/sdd, ID: 1
> >    Device size:             4.55TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             2.78GiB
> >    Data,RAID10:           784.31GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            144.07GiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Metadata,RAID10:       352.00MiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sde, ID: 2
> >    Device size:             4.55TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             2.78GiB
> >    Data,RAID10:           784.31GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            144.07GiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Metadata,RAID10:       352.00MiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sdl, ID: 3
> >    Device size:             3.64TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sdn, ID: 4
> >    Device size:             3.64TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sdm, ID: 5
> >    Device size:             3.64TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sdk, ID: 6
> >    Device size:             3.64TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sdj, ID: 7
> >    Device size:             3.64TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sdi, ID: 8
> >    Device size:             3.64TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Unallocated:             1.02MiB
> >
> > /dev/sdb, ID: 9
> >    Device size:             9.10TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             4.01TiB
> >    Data,RAID10:           784.31GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            458.56GiB
> >    Data,RAID6:            144.07GiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Metadata,RAID10:       352.00MiB
> >    Metadata,RAID10:         6.00GiB
> >    Metadata,RAID1C3:        2.00GiB
> >    System,RAID1C3:         32.00MiB
> >    Unallocated:            82.89GiB
> >
> > /dev/sdc, ID: 10
> >    Device size:             9.10TiB
> >    Device slack:              0.00B
> >    Data,RAID10:             3.12GiB
> >    Data,RAID10:             4.01TiB
> >    Data,RAID10:           784.31GiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            458.56GiB
> >    Data,RAID6:            144.07GiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Metadata,RAID10:       352.00MiB
> >    Metadata,RAID10:         6.00GiB
> >    Metadata,RAID1C3:        3.00GiB
> >    Unallocated:            81.92GiB
> >
> > /dev/sda, ID: 11
> >    Device size:             9.10TiB
> >    Device slack:              0.00B
> >    Data,RAID10:           784.31GiB
> >    Data,RAID10:             4.01TiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            458.56GiB
> >    Data,RAID6:            144.07GiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Metadata,RAID10:       352.00MiB
> >    Metadata,RAID10:         6.00GiB
> >    Metadata,RAID1C3:        5.00GiB
> >    System,RAID1C3:         32.00MiB
> >    Unallocated:            85.79GiB
> >
> > /dev/sdf, ID: 12
> >    Device size:             9.10TiB
> >    Device slack:              0.00B
> >    Data,RAID10:           784.31GiB
> >    Data,RAID10:             4.01TiB
> >    Data,RAID10:             3.34TiB
> >    Data,RAID6:            458.56GiB
> >    Data,RAID6:            144.07GiB
> >    Data,RAID6:            293.03GiB
> >    Metadata,RAID10:         4.47GiB
> >    Metadata,RAID10:       352.00MiB
> >    Metadata,RAID10:         6.00GiB
> >    Metadata,RAID1C3:        5.00GiB
> >    System,RAID1C3:         32.00MiB
> >    Unallocated:            85.79GiB
>
> OK...slack is 0, so there wasn't anything weird with underlying device
> sizes going on.
>
> There's 3 entries for "Data,RAID6" because there are three stripe widths:
> 12 disks, 6 disks, and 4 disks, corresponding to the number of disks of
> each size.  Unfortunately 'dev usage' doesn't say which one is which.
>
> > Wow looks like I've got lots of info to mull over here! I kicked off
> > another convert already after cleaning up quite a bit more space. I
> > had over 100G unallocated on each device after deleting some data and
> > running another balance.
>
> If you did balances with no unallocated space on the small drives, then
> the block groups created by those balances are the first block groups
> to be processed by later balances.  These block groups will be narrow
> so they'll use space less efficiently.  We want the opposite of that.
>

There was unallocated space on all drives before I started this recent
balance. So far it's still chugging along at about 20% complete but I
assume even if this does complete successfully I'll be stuck with some
narrow strips from the first attempt.

> > I'm tempted to let it run and see if it
> > succeeds but my unallocated space has already dropped off a cliff with
> > 95% of the rebalance remaining.
>
> This is why the devid/stripes filters are important.  Also I noticed
> that my logic in my previous reply was wrong for this case:  we do want
> to process the smallest disks first, not the largest ones, because that
> way we guarantee we always increase unallocated space.
>
> If we convert a 10-disk-wide block group from RAID10 to 4-disk-wide
> RAID6, we replace 2 chunks on 10 disks with 5 chunks on 4 disks:
>
>         2 RAID10 block groups:          5 RAID6 block groups:
>         sda #1 data1                    sda #1 data1
>         sdb #1 mirror1                  sdb #1 data2
>         sdc #1 data2                    sdc #1 P1
>         sdd #1 mirror2                  sdf #1 Q1
>         sde #1 data3                    sda #2 data3
>         sdf #1 mirror3                  sdb #2 data4
>         sdg #1 data4                    sdc #2 P2
>         sdh #1 mirror4                  sdf #2 Q2
>         sdi #1 data5                    sda #3 data5
>         sdj #1 mirror5                  sdb #3 data6
>         sda #2 data6                    sdc #3 P3
>         sdb #2 mirror6                  sdf #3 Q3
>         sdc #2 data7                    sda #4 data7
>         sdd #2 mirror7                  sdb #4 data8
>         sde #2 data8                    sdc #4 P4
>         sdf #2 mirror8                  sdf #4 Q4
>         sdg #2 data9                    sda #5 data9
>         sdh #2 mirror9                  sdb #5 data10
>         sdi #2 data10                   sdc #5 P5
>         sdj #2 mirror10                 sdf #5 Q5
>
> When this happens we lose net 3GB of space on each of the 4 largest disks
> for every 1GB we gain on the 6 smaller disks, and run out of space part
> way through the balance.  We will have to make this tradeoff at some
> point in the balance because of the disk sizes, but it's important that
> it happens at the very end, after all other possible conversion is done
> and the maximum amount of unallocated space is generated.
>
> btrfs balance isn't smart enough to do this by itself, which is why it's
> 20 commands with filter parameters to get complex arrays reshaped, and
> there are sometimes multiple passes.
>
> We want to relocate a 10-disk-wide block group from RAID10 to 10-disk-wide
> RAID6, replacing 8 chunks on 10 disks with 5 chunks on 10 disks:
>
>         8 RAID10 block groups:          5 RAID6 block groups:
>         sda #1 data1                    sda #1 data1
>         sdb #1 mirror1                  sdb #1 data2
>         sdc #1 data2                    sdc #1 data3
>         sdd #1 mirror2                  sdd #1 data4
>         sde #1 data3                    sde #1 data5
>         sdf #1 mirror3                  sdf #1 data6
>         sdg #1 data4                    sdg #1 data7
>         sdh #1 mirror4                  sdh #1 data8
>         sdi #1 data5                    sdi #1 P1
>         sdj #1 mirror5                  sdj #1 Q1
>         sda #2 data6                    sda #2 data9
>         sdb #2 mirror6                  sdb #2 data10
>         sdc #2 data7                    sdc #2 data11
>         sdd #2 mirror7                  sdd #2 data12
>         sde #2 data8                    sde #2 data13
>         sdf #2 mirror8                  sdf #2 data14
>         sdg #2 data9                    sdg #2 data15
>         sdh #2 mirror9                  sdh #2 data16
>         sdi #2 data10                   sdi #2 P2
>         sdj #2 mirror10                 sdj #2 Q2
>         ...etc there are 40GB of data
>
> The easiest way to do that is:
>
>         for sc in 12 11 10 9 8 7 6 5 4; do
>                 btrfs balance start -dconvert=raid6,stripes=$sc..$sc,soft -mconvert=raid1c3,soft /mnt/storage-array/
>         done
>
> The above converts the widest block groups first, so that every block
> group converted results in a net increase in storage efficiency, and
> creates unallocated space on as many disks as possible.
>
> Then the next step from my original list, edited with the device
> IDs and sizes from dev usage, is the optimization step.  I filled
> in the device IDs and sizes from your 'dev usage' output:
>
> > >         4.  balance -dstripes=1..5,devid=1  # sdd, 4.55TB
> > >             balance -dstripes=1..5,devid=2  # sde, 4.55TB
> > >             balance -dstripes=1..11,devid=3 # sdl, 3.64TB
> > >             balance -dstripes=1..11,devid=4 # sdn, 3.64TB
> > >             balance -dstripes=1..11,devid=5 # sdm, 3.64TB
> > >             balance -dstripes=1..11,devid=6 # sdk, 3.64TB
> > >             balance -dstripes=1..11,devid=7 # sdj, 3.64TB
> > >             balance -dstripes=1..11,devid=8 # sdi, 3.64TB
> > >             balance -dstripes=1..3,devid=9  # sdb, 9.10TB
> > >             balance -dstripes=1..3,devid=10 # sdc, 9.10TB
> > >             balance -dstripes=1..3,devid=11 # sda, 9.10TB
> > >             balance -dstripes=1..3,devid=12 # sdf, 9.10TB
>
> This ensures that each disk is a member of an optimum width block
> group for the disk size.
>
> Note: I'm not sure about the 1..11.  IIRC the btrfs limit is 10 disks
> per stripe, so you might want to use 1..9 if it seems to be trying
> to rebalance everything with 1..11.
>
> Running 'watch btrfs fi usage /mnt/storage-array' while balance runs
> can be enlightening.

Thanks so much for all this detail. I'll see how this run goes and if
it gets stuck again I'll try your strategy of converting to RAID-1 to
get back some unallocated space. Otherwise if this completes
successfully I'll go ahead with optimizing the striping and let you
know how it goes.



-- 
---------------------------------------
John Petrini
