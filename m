Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBE22B6AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 21:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGWT3Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 23 Jul 2020 15:29:24 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35916 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWT3Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 15:29:24 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 28C3B77B543; Thu, 23 Jul 2020 15:29:21 -0400 (EDT)
Date:   Thu, 23 Jul 2020 15:29:21 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     kreijack@inwind.it, John Petrini <john.d.petrini@gmail.com>,
        John Petrini <me@johnpetrini.com>, linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data
 Conversion
Message-ID: <20200723192921.GA5890@hungrycats.org>
References: <CADvYWxdvy5n3Tsa+MG9sSB2iAu-eA+W33ApzQ3q9D6sdGR9UYA@mail.gmail.com>
 <CAJix6J9kmQjfFJJ1GwWXsX7WW6QKxPqpKx86g7hgA4PfbH5Rpg@mail.gmail.com>
 <20200716225731.GI10769@hungrycats.org>
 <CADvYWxcMCEvOg8C-gbGRC1d02Z6TCypvsan7mi+8U2PVKwfRwQ@mail.gmail.com>
 <20200717055706.GJ10769@hungrycats.org>
 <de9a3d52-0147-255c-4c39-09bf734e1435@steev.me.uk>
 <507b649c-ac60-0b5c-222f-192943c50f16@libero.it>
 <e058a1d9aea61756db2296b0a26051cc@steev.me.uk>
 <f7771864-9503-646d-dbda-63a43844d230@inwind.it>
 <20a7c0211b2d9336b69d48fa5c3d0c5c@steev.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20a7c0211b2d9336b69d48fa5c3d0c5c@steev.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 23, 2020 at 09:57:50AM +0100, Steven Davies wrote:
> On 2020-07-21 21:48, Goffredo Baroncelli wrote:
> > On 7/21/20 12:15 PM, Steven Davies wrote:
> > > On 2020-07-20 18:57, Goffredo Baroncelli wrote:
> > > > On 7/18/20 12:36 PM, Steven Davies wrote:
> 
> > > > > > > /dev/sdf, ID: 12
> > > > > > >     Device size:             9.10TiB
> > > > > > >     Device slack:              0.00B
> > > > > > >     Data,RAID10:           784.31GiB
> > > > > > >     Data,RAID10:             4.01TiB
> > > > > > >     Data,RAID10:             3.34TiB
> > > > > > >     Data,RAID6:            458.56GiB
> > > > > > >     Data,RAID6:            144.07GiB
> > > > > > >     Data,RAID6:            293.03GiB
> > > > > > >     Metadata,RAID10:         4.47GiB
> > > > > > >     Metadata,RAID10:       352.00MiB
> > > > > > >     Metadata,RAID10:         6.00GiB
> > > > > > >     Metadata,RAID1C3:        5.00GiB
> > > > > > >     System,RAID1C3:         32.00MiB
> > > > > > >     Unallocated:            85.79GiB
> > > > > > 
> > > > [...]
> > > > > 
> > > > > RFE: improve 'dev usage' to show these details.
> > > > > 
> > > > > As a user I'd look at this output and assume a bug in
> > > > > btrfs-tools because of the repeated conflicting information.
> > > > 
> > > > What would be the expected output ?
> > > > What about the example below ?
> > > > 
> > > >  /dev/sdf, ID: 12
> > > >      Device size:             9.10TiB
> > > >      Device slack:              0.00B
> > > >      Data,RAID10:           784.31GiB
> > > >      Data,RAID10:             4.01TiB
> > > >      Data,RAID10:             3.34TiB
> > > >      Data,RAID6[3]:         458.56GiB
> > > >      Data,RAID6[5]:         144.07GiB
> > > >      Data,RAID6[7]:         293.03GiB
> > > >      Metadata,RAID10:         4.47GiB
> > > >      Metadata,RAID10:       352.00MiB
> > > >      Metadata,RAID10:         6.00GiB
> > > >      Metadata,RAID1C3:        5.00GiB
> > > >      System,RAID1C3:         32.00MiB
> > > >      Unallocated:            85.79GiB
> > > 
> > > That works for me for RAID6. There are three lines for RAID10 too -
> > > what's the difference between these?
> > 
> > The differences is the number of the disks involved. In raid10, the
> > first 64K are on the first disk, the 2nd 64K are in the 2nd disk and
> > so until the last disk. Then the n+1 th 64K are again in the first
> > disk... and so on.. (ok I missed the RAID1 part, but I think the have
> > giving the idea )
> > 
> > So the chunk layout depends by the involved number of disk, even if
> > the differences is not so dramatic.
> 
> Is this information that the user/sysadmin needs to be aware of in a similar
> manner to the original problem that started this thread? If not I'd be
> tempted to sum all the RAID10 chunks into one line (each for data and
> metadata).

It's useful for all profiles that use striping across a variable number
of devices.  That's RAID0, RAID5, RAID6, and RAID10.  The other profiles
don't use stripes and have a fixed device count (i.e. RAID1 is always 2
disks, can never be 1 or 3), so there's no need to distinguish them in a
'dev usage' or 'fi usage' style view.

All the profiles that support variable numbers of devices are also
profiles that use striping, so the terms "stripe" and "disk" are used
interchangably for those profiles.

> > > >     Data,RAID6:        123.45GiB
> > > >         /dev/sda     12.34GiB
> > > >         /dev/sdb     12.34GiB
> > > >         /dev/sdc     12.34GiB
> > > >     Data,RAID6:        123.45GiB
> > > >         /dev/sdb     12.34GiB
> > > >         /dev/sdc     12.34GiB
> > > >         /dev/sdd     12.34GiB
> > > >         /dev/sde     12.34GiB
> > > >         /dev/sdf     12.34GiB
> > > 
> > > Here there would need to be something which shows what the
> > > difference in the RAID6 blocks is - if it's the chunk size then I'd
> > > do the same as the above example with e.g. Data,RAID6[3].
> > 
> > We could add a '[n]' for the profile where it matters, e.g. raid0,
> > raid10, raid5, raid6.
> > What do you think ?
> 
> So like this? That would make sense to me, as long as the meaning of [n] is
> explained in --help or the manpage.
>      Data,RAID6[3]:     123.45GiB
>          /dev/sda     12.34GiB
>          /dev/sdb     12.34GiB
>          /dev/sdc     12.34GiB
>      Data,RAID6[5]:     123.45GiB
>          /dev/sdb     12.34GiB
>          /dev/sdc     12.34GiB
>          /dev/sdd     12.34GiB
>          /dev/sde     12.34GiB
>          /dev/sdf     12.34GiB

It is quite useful to know how much data is used by each _combination_
of disks.  e.g. for a 3-device RAID1 we might want to know about this:

      Data,RAID1:     124.67GiB
          /dev/sda,/dev/sdb     99.99GiB
          /dev/sda,/dev/sdc     12.34GiB
          /dev/sdb,/dev/sdc     12.34GiB

Here there are many more block groups using /dev/sda and /dev/sdb than
there are other pairs of disks.  This may cause problems if disks are
added, removed, or resized, as there may not be enough space on the
/dev/sda,/dev/sdb pair to accommodate data moved from other disks.
Balance may be required to redistribute the sda,sdb block groups onto
sda,sdc and sdb,sdc block groups.

The device breakdown above is sorted device lists, so e.g. a block group
that uses '/dev/sdc,/dev/sda' would be sorted and appear as part of the
'/dev/sda,/dev/sdc' total.  For space-management purposes we do not care
which disk is mirror/stripe 0 and which is mirror/stripe 1, they take
up the same space either way.

In this case it may be better to separate out the device ID's.
There could be a pathological case like:

	/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd,/dev/sde,/dev/sdf,/dev/sdg,/dev/sdh,/dev/sdi,/dev/sdj,/dev/sdk,/dev/sdl   12.34GB

which might be better written as:

    Device ID 1: /dev/sda
    Device ID 2: /dev/sdb
    Device ID 3: /dev/sdc
    [...]
    Device ID 11: /dev/sdk
    Device ID 12: /dev/sdl

    Data,RAID6[12]:    123.45GiB
        [1,2,3,4,5,6,7,8,9,10,11,12]    123.45GiB

    Data,RAID6[9]:    345.67GiB
        [1,2,3,4,8,9,10,11,12]    123.45GiB
        [1,2,4,5,6,9,10,11,12]    111.11GiB
        [1,2,3,4,6,8,9,11,12]     111.11GiB

If we see that, we know the 12-stripe-wide RAID6 is OK, but maybe some
of the 9-stripe-wide needs to be relocated depending on which disks are
the larger ones.  We would then run some balances with stripe= and devid=
filters e.g. to get rid of 9-stripe-wide RAID6 on devid 5.

> 
> -- 
> Steven Davies
