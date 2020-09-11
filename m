Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44EF266232
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 17:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgIKPdk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 11 Sep 2020 11:33:40 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34770 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIKPdX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 11:33:23 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BC7D97FAFA8; Fri, 11 Sep 2020 11:33:20 -0400 (EDT)
Date:   Fri, 11 Sep 2020 11:33:20 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Miloslav =?utf-8?B?SMWvbGE=?= <miloslav.hula@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: No space left after add device and balance
Message-ID: <20200911153320.GE5890@hungrycats.org>
References: <9224b373-82ee-60c4-4bd1-be359db75ea1@gmail.com>
 <CAJCQCtQYSPO6Wd2u=WK-mia0WTjU0BybhhhhbT5VZUczUfx+JQ@mail.gmail.com>
 <d1339a91-0a04-538c-59ca-30bc05b636a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d1339a91-0a04-538c-59ca-30bc05b636a5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 11, 2020 at 12:29:32PM +0200, Miloslav Hůla wrote:
> Dne 10.09.2020 v 21:18 Chris Murphy napsal(a):
> > On Wed, Sep 9, 2020 at 2:15 AM Miloslav Hůla <miloslav.hula@gmail.com> wrote:
> > 
> > > After ~15.5 hours finished successfully. Unfortunetally, I have no exact
> > > free space report before first balance, but it looked roughly like:
> > > 
> > > Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
> > >           Total devices 16 FS bytes used 3.49TiB
> > >           devid    1 size 558.41GiB used 448.66GiB path /dev/sda
> > >           devid    2 size 558.41GiB used 448.66GiB path /dev/sdb
> > >           devid    4 size 558.41GiB used 448.66GiB path /dev/sdd
> > >           devid    5 size 558.41GiB used 448.66GiB path /dev/sde
> > >           devid    7 size 558.41GiB used 448.66GiB path /dev/sdg
> > >           devid    8 size 558.41GiB used 448.66GiB path /dev/sdh
> > >           devid    9 size 558.41GiB used 448.66GiB path /dev/sdf
> > >           devid   10 size 558.41GiB used 448.66GiB path /dev/sdi
> > >           devid   11 size 558.41GiB used 448.66GiB path /dev/sdj
> > >           devid   13 size 558.41GiB used 448.66GiB path /dev/sdk
> > >           devid   14 size 558.41GiB used 448.66GiB path /dev/sdc
> > >           devid   15 size 558.41GiB used 448.66GiB path /dev/sdl
> > >           devid   16 size 558.41GiB used 448.66GiB path /dev/sdm
> > >           devid   17 size 558.41GiB used 448.66GiB path /dev/sdn
> > >           devid   18 size 837.84GiB used 448.66GiB path /dev/sdr
> > >           devid   19 size 837.84GiB used 448.66GiB path /dev/sdq
> > >           devid   20 size 837.84GiB used   0.00GiB path /dev/sds
> > >           devid   21 size 837.84GiB used   0.00GiB path /dev/sdt
> > > 
> > > 
> > > Are we doing something wrong? I found posts, where problems with balace
> > > of full filesystem are described. And as a recommendation is "add empty
> > > device, run balance, remove device".
> > 
> > It's raid10, so in this case, you probably need to add 4 devices. It's
> > not required they be equal sizes but it's ideal.

Something is wrong there.  Each new balanced chunk will free space
on the first 16 drives (each new chunk is 9GB, each old one is 8GB,
so the number of chunks on each of the old disks required to hold the
same data decreases by 1/8th each time a chunk is relocated in balance).
Every drive had at least 100GB of unallocated space at the start, so the
first 9GB chunk should have been allocated without issue.  Assuming nobody
was aggressively writing to the disk during the balance to consume all
available space, it should not have run out of space in a full balance.

You might have hit a metadata space reservation bug, especially on an
older kernel.  It's hard to know what happened without a log of the
'btrfs fi usage' data over time and a stack trace of the ENOSPC event,
but whatever it was, it was probably fixed some time in the last 4
years.

There's a bug (up to at least 5.4) where scrub locks chunks and triggers
aggressive metadata overallocations, which can lead to this result.
It forms a feedback loop where scrub keeps locking the metadata chunk that
balance is using, so balance allocates another metadata chunk, then scrub
moves on and locks that new metadata chunk, repeat until out of space,
abort transaction, all the allocations get rolled back and disappear.
Only relevant if you were running a scrub at the same time as balance.

> > > Are there some requirements on free space for balance even if you add
> > > new device?
> > 
> > The free space is reported upon adding the two devices; but the raid10
> > profile requires more than just free space, it needs free space on
> > four devices.
> 
> I didn't realize that. It makes me sense now. So we are probably "wrong"
> with 18 devices. Multiple of 4 would be better I guess.

Not really.  btrfs profile "raid10" distribute stripes over pairs of
mirrored drives.  It will allocate raid10 chunks on 4 + N * 2 drives at a
time, but each chunk can use different drives so all the space is filled.
Any number of disks above 4 is OK (including odd numbers), but sequential
read performance will only increase when the number of drives increases
to the next even number so the next highest stripe width can be used.

i.e. 5 drives will provide more space than 4, but 5 drives will not be
significantly faster than 4.  6 is faster and larger than 4 or 5.
7 will be larger, 8 will be larger and faster, 9 will be larger, etc.
(assuming all the drives are identical)

At some point there's a chunk size limit that kicks in and limits the
number of drives in a chunk, but I'm not sure what the limit is (the
kernel code does math on struct and block sizes and the result isn't
obvious to me).  I think it ends up being 10 of something, but not sure
if the unit is drives (in which case your 16 drives were already over
the limit) or gigabytes of logical chunk size (for raid10 that means
20 drives).  Once that limit is reached, adding more drives only increases
space and does not improve sequential read performance any further.

> Thank you!
