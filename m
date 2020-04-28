Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C931BCECE
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgD1Vfy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 28 Apr 2020 17:35:54 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36438 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1Vfx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 17:35:53 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 82B3B696BF9; Tue, 28 Apr 2020 17:35:51 -0400 (EDT)
Date:   Tue, 28 Apr 2020 17:35:51 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200428213551.GC10796@hungrycats.org>
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org>
 <20200428181436.GA5402@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200428181436.GA5402@schmorp.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 28, 2020 at 08:14:36PM +0200, Marc Lehmann wrote:
> Hi, thanks for your reply!
> 
> On Tue, Apr 28, 2020 at 02:19:59AM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > That is _not_ expected.  Directories in btrfs are stored entirely in
> > metadata as btrfs items.  They do not have data blocks in data block
> > groups.
> 
> Ah, ok, yes, I agree then. I wrongly assumed directory data would be
> stored as file data. I am actually very happy to be wrong about this, as
> it makes me even more confident when facing a missing disk in production,
> which is bound to happen.
> 
> That is strange then - I was able to delete the directories (and obviously
> the files inside) though, but I did that _after_ "regenerating" the
> metadata by balancing.
> 
> The only other inconsistency is that
> 
>    btrfs ba start -musage=100 -mdevid=2
> 
> kept failing with ENOSPC after doing some work, and
> 
>    btrfa ba start -mconvert=dup
> 
> worked flawlessly and apparently fixed all errors (other than missing file
> data). Maybe the difference is the -mdevid=2 - although the disk had more
> than 100G of unallocated space, so that alone wouldn't epxlain the enospc.

I'm not sure, but my guess is the allocator may have noticed you have
only one disk in degraded mode, and will not be able to allocate more
raid1 block groups (which require 2 disks).  A similar thing happens
when raid5 arrays degrade--allocation continues on remaining disks,
in new block groups.

> Just FYI, here are example kernel messages for such a failed balance with
> only -musage:
> 
> Apr 24 22:08:01 doom kernel: [ 4051.894190] BTRFS info (device dm-32): balance: start -musage=100,devid=2
> Apr 24 22:08:02 doom kernel: [ 4052.194964] BTRFS info (device dm-32): relocating block group 35508773191680 flags metadata|raid1
> Apr 24 22:08:02 doom kernel: [ 4052.296436] BTRFS info (device dm-32): relocating block group 35507699449856 flags metadata|raid1
> Apr 24 22:08:02 doom kernel: [ 4052.410760] BTRFS info (device dm-32): relocating block group 35506625708032 flags metadata|raid1
> Apr 24 22:08:02 doom kernel: [ 4052.552481] BTRFS info (device dm-32): relocating block group 35505551966208 flags metadata|raid1
> Apr 24 22:08:03 doom kernel: [ 4052.940950] BTRFS info (device dm-32): relocating block group 35504478224384 flags metadata|raid1
> Apr 24 22:08:03 doom kernel: [ 4053.047505] BTRFS info (device dm-32): relocating block group 35503404482560 flags metadata|raid1
> Apr 24 22:08:03 doom kernel: [ 4053.128938] BTRFS info (device dm-32): relocating block group 35502330740736 flags metadata|raid1
> Apr 24 22:08:03 doom kernel: [ 4053.218385] BTRFS info (device dm-32): relocating block group 35501256998912 flags metadata|raid1
> Apr 24 22:08:03 doom kernel: [ 4053.326941] BTRFS info (device dm-32): relocating block group 35500183257088 flags metadata|raid1
> Apr 24 22:08:03 doom kernel: [ 4053.432318] BTRFS info (device dm-32): relocating block group 35499109515264 flags metadata|raid1
> Apr 24 22:08:22 doom kernel: [ 4072.112133] BTRFS info (device dm-32): found 50845 extents
> Apr 24 22:08:27 doom kernel: [ 4077.002724] BTRFS info (device dm-32): 3 enospc errors during balance
> Apr 24 22:08:27 doom kernel: [ 4077.002727] BTRFS info (device dm-32): balance: ended with status: -28

> > > multiple times larger than the memory size, i.e. it was almost certainly
> > > writing to directories long _after_ btrfs got an EIO for the respective
> > > directory blocks. 
> > 
> > There would be a surviving mirror copy of the directory, because it's in
> > raid1 metadata, so that should be a successful write in degraded mode.
> > 
> > Uncorrectable EIO on metadata triggers a hard shutdown of all writes to
> > the filesystem.  Userspace will definitely be informed when that happens.
> > It's something we'd want to avoid with raid1.
> 
> Does "Uncorrectable EIO" also mean writes, though? I know from experience
> that I get EIO when btrfs hits a metadata error, and that nowadays it is
> very successfull in correcting metadata errors (which is a relatively new
> thing).

Either.  EIO is the result of _two_ read or write failures (for raid1).

> My main takeaway from this experiment was that a) I did get my filesystem
> back without having to reformat, which is admirable, and b) I can write a
> surprising amount of data to a missing disk without seeing anything more
> than kernel messages. In my stupidity I can well imagine having a disk
> falling out of the "array" and me not noticing it for days.

It's critical to continuously monitor btrfs raids by polling 'btrfs
dev stats'.  Ideally there would be an ioctl or something that would
block until they change, so an alert can be generated without polling.

This is true of most raid implementations.  The whole point of a RAID1
is to _not_ report correctable errors on individual drives to userspace
applications.  There is usually(*) a side-channel for monitoring error
rates, and producing alert notifications when those are not zero.

(*) There are a few RAID implementations out there that don't implement
a monitoring channel, or it's unreliable or hard to use.  When you find
such a RAID implementation, it should be placed directly in an appropriate
e-waste recycling bin.

> Arguably, that is how it is though - a write error does not cause btrfs to
> dismiss the whole disk, and most write errors cannot be reported back to
> userspace, so btrfs would somehow have to correlate write errors and decide
> when enough is enough.

That's a black art at the best of times.  Monitoring software can implement
corrective action, and by not being part of the kernel it can be easily
customized for various levels of error tolerance and response.

That said, some of the response tools are lacking, e.g. 'btrfs replace'
doesn't allow you to rewrite an existing drive with its own contents,
you have to take it offline first (bad: putting the array in degraded
mode) or use a separate disk as the replace target (bad: needs one more
disk than you have).  If you have a disk with known corruption, only
'scrub' will repair it in-place (bad: doesn't work on nodatacow files,
and only works 99.999999925% of the time with crc32c csums).

> OTOH, write errors are very rare on normal disks, and raid controllers
> usually immediately kick out a disk on write errors so maybe marking
> the disk bad (until a remount or so) might be a good idea - with modenr
> drives, write errors are almost alwyays a symptom of something very bad
> happening that is usually not directly associated with a specific block -
> for example, an SSD disk mightr be end-of-life and switch to read-onyl, or
> a conventional disk might have run out of spare blocks.
> 
> i.e. maybe btrfs shouldn't treat write errors as less bad than read
> errors - not sure.

Cheap SSDs (and some NAS HDDs) corrupt data randomly without any
indication of failure at all--you have to find the damage with a scrub
later on, and the drive _never_ reports an error even when it is clearly
and obviously and repeatedly failing.  It's hard to imagine how a drive
could behave worse--even locking up the bus is better, at least it's
something different from the "successfully completed" response to a
write or flush command.  No filesystem can detect these errors at
write time.  I'm pretty sure even the disk firmware doesn't know.

Given disks like those, applications cannot rely on write time IO
failure detection--some data is gonna get lost, probably while you're not
watching.  As a service operator I have to ensure that applications are
adequately protected against data loss from write time to the next read
time and later--a scope which includes much more than merely reporting
an IO error during the write.  That means designing applications to not
rely on writing to local disks at all (e.g. multi-host replication), so
what the local filesystem says about the success or failure of a single
individual write operation is not usually interesting.  (*)

All that said, from what you've described, it sounds like there are still
failures even on the stuff btrfs does well?  e.g. there should not have
been a directory search problem at _any_ time with that setup.

(*) Read errors are super important though--even the ones not reported
to userspace--as they are direct evidence of drive failure.  Since 5.0,
btrfs silently ignores some of those, and this even got backported to
4.19 and earlier LTS kernels.  >:-(

> > > This is substantiated by the fact that I was able to
> > > list the directories before rebooting, but not afterwards, so some info
> > > lived in blocks which were not writtem but were still cached.
> > 
> > It sounds like you hit some other kind of failure there (this and the
> > "page private not zero" messages.  What kernel was this?
> 
> 5.4.28 from mainline-ppa (https://kernel.ubuntu.com/~kernel-ppa/mainline/).
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
