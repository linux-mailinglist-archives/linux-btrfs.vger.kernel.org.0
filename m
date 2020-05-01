Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481E31C0BD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 03:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEABzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 21:55:24 -0400
Received: from mail.nethype.de ([5.9.56.24]:43333 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEABzY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 21:55:24 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jUKtd-000XOv-4b; Fri, 01 May 2020 01:55:21 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jUKtc-0002dM-Vu; Fri, 01 May 2020 01:55:20 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jUKtc-00008d-VU; Fri, 01 May 2020 03:55:20 +0200
Date:   Fri, 1 May 2020 03:55:20 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200501015520.GA8491@schmorp.de>
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org>
 <20200428181436.GA5402@schmorp.de>
 <20200428213551.GC10796@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428213551.GC10796@hungrycats.org>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 28, 2020 at 05:35:51PM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > worked flawlessly and apparently fixed all errors (other than missing file
> > data). Maybe the difference is the -mdevid=2 - although the disk had more
> > than 100G of unallocated space, so that alone wouldn't epxlain the enospc.
> 
> I'm not sure, but my guess is the allocator may have noticed you have
> only one disk in degraded mode, and will not be able to allocate more
> raid1 block groups (which require 2 disks).  A similar thing happens
> when raid5 arrays degrade--allocation continues on remaining disks,
> in new block groups.

There were at least 2 other disks with some unallocated data available. Could
the -mdevid=2 have limited the allocation or reading somehow?

> > > the filesystem.  Userspace will definitely be informed when that happens.
> > > It's something we'd want to avoid with raid1.
> > 
> > Does "Uncorrectable EIO" also mean writes, though? I know from experience
> > that I get EIO when btrfs hits a metadata error, and that nowadays it is
> > very successfull in correcting metadata errors (which is a relatively new
> > thing).
> 
> Either.  EIO is the result of _two_ read or write failures (for raid1).

But then btrfs doesn't correct underlying EIO errors on write in raid1,
i.e. it gets EIO from the block write, and doesn't fix it.

> > My main takeaway from this experiment was that a) I did get my filesystem
> > back without having to reformat, which is admirable, and b) I can write a
> > surprising amount of data to a missing disk without seeing anything more
> > than kernel messages. In my stupidity I can well imagine having a disk
> > falling out of the "array" and me not noticing it for days.
> 
> It's critical to continuously monitor btrfs raids by polling 'btrfs
> dev stats'.  Ideally there would be an ioctl or something that would
> block until they change, so an alert can be generated without polling.

Right, that might be helpful.

> This is true of most raid implementations.  The whole point of a RAID1
> is to _not_ report correctable errors on individual drives to userspace
> applications.  There is usually(*) a side-channel for monitoring error
> rates, and producing alert notifications when those are not zero.

Well, the data wasn't raid1, but single, and no error was ever reported.

My concern is that btrfs will happily, continously and mostly silently loose
data practically forever by assuming a disk that gives an error on every
access is still there and able to hold data.

That behaviour is very different to other "raid" implementations.

> 'scrub' will repair it in-place (bad: doesn't work on nodatacow files,
> and only works 99.999999925% of the time with crc32c csums).

I assume that calculations assumes random bit errors - but that is rarely
the case. In this case, for example, there were no crc32 errors, all
detection came from other layers ("parent transid failed" etc.).

> Cheap SSDs (and some NAS HDDs) corrupt data randomly without any
[...]
> All that said, from what you've described, it sounds like there are still

I'm not sure I can follow you here completely - form what you write, it
sounds like "some disks fail silently, so btrfs doesn't care when disks fail
loudly".

I mean, in the case described, there were no silent failures except maybe in
the split second before the disk disconnected (and not even then when the
raid controller keeps the cache and writes it later).

All failures were properly reported (by device-mapper ion this case), i.e.
every read and write caused an EIO to be reported to btrfs from the block
layer.

Just because some disks behave bad doesn't seem like sufficient reason to
me to completely ignore cases whwre errors _are_ being reported.

I don't think my case is very unlikely - it's basically how linux behaves
when lvm is used and, say, one of your disks has a temporary outage - the
device node might go away and all accesses will rersult in EIO.

Other filesystems can get around this by not supporting multiple devices and
relying on underlying systems (e.g. software or hardware raid) to make the
disks appear a single device.

I do think btrfs would need more robust error handling for such cases -
I don't know *any* raid implementation that ignores write errors, for
example, and I don't think there is any raid implementation that ignores
missing disks.

> failures even on the stuff btrfs does well?  e.g. there should not have
> been a directory search problem at _any_ time with that setup.

That was my expectation, although I am well aware that this is still under
development. I am already positively surprised that I was able to get an
(apparently) fully functional filesystem back after something so drastic,
with relatively little effort (metadata profile conversion).

Tooling is not so much of an issue for me, the biggest issue would be
detecting which files are on the missing disk, and if I can't come up with
something better (e.g. ioctls to query the data block location), I can
always read all files and see which of them error out and restore them.

> (*) Read errors are super important though--even the ones not reported
> to userspace--as they are direct evidence of drive failure.

Under what conditions are write errors not even more direct evidence
of drive failure (usually, but not exclusively, indicating far bigger
problems than single block errors)?

> Since 5.0, btrfs silently ignores some of those, and this even got
> backported to 4.19 and earlier LTS kernels. >:-(

eh, cool, uh :)

Well, I assume that my case of concern - single disk failure - is not
something that will escape my attention forever, so doing a manual
metadata balance is fully viable for me.

My concern is merely that btrfs stubbornly insists a completely missing
disk is totally fine to write to, essentially forever :)

I'm not saying alerting userspace is required in some way. But maybe
btrfs should not consider an obviously badly broken disk as healthy. I
would have expected btrfs to stop writing to a disk when it is told in no
unclear terms that the write failed, at leats at some point.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
