Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA561C0CAA
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 05:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEADhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 23:37:22 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36000 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgEADhW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 23:37:22 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7CE0269CD11; Thu, 30 Apr 2020 23:37:20 -0400 (EDT)
Date:   Thu, 30 Apr 2020 23:37:20 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200501033720.GF10769@hungrycats.org>
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org>
 <20200428181436.GA5402@schmorp.de>
 <20200428213551.GC10796@hungrycats.org>
 <20200501015520.GA8491@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501015520.GA8491@schmorp.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 03:55:20AM +0200, Marc Lehmann wrote:
> On Tue, Apr 28, 2020 at 05:35:51PM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > > worked flawlessly and apparently fixed all errors (other than missing file
> > > data). Maybe the difference is the -mdevid=2 - although the disk had more
> > > than 100G of unallocated space, so that alone wouldn't epxlain the enospc.
> > 
> > I'm not sure, but my guess is the allocator may have noticed you have
> > only one disk in degraded mode, and will not be able to allocate more
> > raid1 block groups (which require 2 disks).  A similar thing happens
> > when raid5 arrays degrade--allocation continues on remaining disks,
> > in new block groups.
> 
> There were at least 2 other disks with some unallocated data available. Could
> the -mdevid=2 have limited the allocation or reading somehow?

It shouldn't.  Balance will happily copy data to a different location on the
same device, and if you have at least 2 disks with unallocated then
raid1 allocation should always succeed.  Doesn't mean there isn't a
bug there though.  The btrfs allocator is full of 5-year-old bugs,
a few get fixed every month.

> > > > the filesystem.  Userspace will definitely be informed when that happens.
> > > > It's something we'd want to avoid with raid1.
> > > 
> > > Does "Uncorrectable EIO" also mean writes, though? I know from experience
> > > that I get EIO when btrfs hits a metadata error, and that nowadays it is
> > > very successfull in correcting metadata errors (which is a relatively new
> > > thing).
> > 
> > Either.  EIO is the result of _two_ read or write failures (for raid1).
> 
> But then btrfs doesn't correct underlying EIO errors on write in raid1,
> i.e. it gets EIO from the block write, and doesn't fix it.

Fixing it would mean repeating the same write--btrfs doesn't feed back
into the allocator to try to reallocate the data on a block group with
at least one chunk disk online.  Nothing to do there.

> > > My main takeaway from this experiment was that a) I did get my filesystem
> > > back without having to reformat, which is admirable, and b) I can write a
> > > surprising amount of data to a missing disk without seeing anything more
> > > than kernel messages. In my stupidity I can well imagine having a disk
> > > falling out of the "array" and me not noticing it for days.
> > 
> > It's critical to continuously monitor btrfs raids by polling 'btrfs
> > dev stats'.  Ideally there would be an ioctl or something that would
> > block until they change, so an alert can be generated without polling.
> 
> Right, that might be helpful.
> 
> > This is true of most raid implementations.  The whole point of a RAID1
> > is to _not_ report correctable errors on individual drives to userspace
> > applications.  There is usually(*) a side-channel for monitoring error
> > rates, and producing alert notifications when those are not zero.
> 
> Well, the data wasn't raid1, but single, and no error was ever reported.

The metadata was raid1, that's all that should matter.

> My concern is that btrfs will happily, continously and mostly silently loose
> data practically forever by assuming a disk that gives an error on every
> access is still there and able to hold data.
> 
> That behaviour is very different to other "raid" implementations.

Be careful what you ask for:  you have configured a filesystem that can
tolerate metadata write failures (raid1 insists on continuous operation
in degraded mode).  Fine, btrfs checks for metadata write failures, and
handles them by forcing itself read-only.  Data block async write failures
are not normally reported to userspace unless reports are explicitly
requested, so it doesn't matter that the single profile data block writes
are failing, there's nowhere to report those errors.  So it's going to
tolerate all the failures in metadata because that's what you asked for,
and ignore all the failures in data because that's what you asked for.

If your applications didn't call fsync() or use O_SYNC or O_DIRECT or
any of the other weird and wonderful ways to ask the filesystem to tell
you about data block write errors, then userspace won't learn anything
about data block write errors on most Linux filesystems.  The system
calls will exit before the disk is even touched, so there's no way to
tell the application that a delalloc extent write, which maybe happens
30 seconds after the application closed the file, didn't work.  Nor is it
reasonable to shut down the entire filesystem because of a deferred
non-metadata write failure (well, maybe it's reasonable if btrfs had a
'errors=remount-ro' option like ext4's).

If you contrive a test case where other filesystems are able to write
their metadata without error, but all data block writes (excluding
directory block writes) fail with EIO, they will do the same thing as btrfs.
It's a simple experiment with a USB stick (make sure to defeat your distro
which might be mounting with 'sync'):  write a multi-megabyte file to a
filesystem on the USB stick with 'cat', and let cat finish the write and
close the file without error.  Then immediately pull the USB stick out
before writeback starts.  Result:  the application sees write success,
the file is gone (or, depending on the filesystem, contains garbage),
and the only indication of failure is a handful of kernel messages about
the lost USB device.

If you write a file and you do call fsync() on btrfs, and fsync() doesn't
report an IO error, that's...possibly?...a bug.  If fsync writes the data
to metadata block groups then there will be no error because a failure
did not happen, but if fsync writes the data to data block groups then
a failure does happen and fsync should report it.  So e.g. a small file
that becomes an inline extent won't trigger an error (and won't be lost)
but a larger file will.

Other "raid" implementations for the most part don't support "care about
some data but not others" operating modes like the ones btrfs has.
There's nothing like data-single/metadata-raid1 in any standard RAID
configuration.  Each profile is operating correctly according to its
rules, even if the combination of those rules doesn't make much sense
in terms of real-world use cases.

> > 'scrub' will repair it in-place (bad: doesn't work on nodatacow files,
> > and only works 99.999999925% of the time with crc32c csums).
> 
> I assume that calculations assumes random bit errors - but that is rarely
> the case. In this case, for example, there were no crc32 errors, all
> detection came from other layers ("parent transid failed" etc.).

Parent transid verification happens after csum checks.  For metadata, the
csum is stored inline in the block, so any older version of the metadata
(e.g. a page that was previously present but failed to be overwritten)
will pass the csum check but fail the later checks on level and transid.

> > Cheap SSDs (and some NAS HDDs) corrupt data randomly without any
> [...]
> > All that said, from what you've described, it sounds like there are still
> 
> I'm not sure I can follow you here completely - form what you write, it
> sounds like "some disks fail silently, so btrfs doesn't care when disks fail
> loudly".
> 
> I mean, in the case described, there were no silent failures except maybe in
> the split second before the disk disconnected (and not even then when the
> raid controller keeps the cache and writes it later).
> 
> All failures were properly reported (by device-mapper ion this case), i.e.
> every read and write caused an EIO to be reported to btrfs from the block
> layer.
> 
> Just because some disks behave bad doesn't seem like sufficient reason to
> me to completely ignore cases whwre errors _are_ being reported.
> 
> I don't think my case is very unlikely - it's basically how linux behaves
> when lvm is used and, say, one of your disks has a temporary outage - the
> device node might go away and all accesses will rersult in EIO.

Were the read accesses not returning EIO?  That would be a bug.

Asynchronous writes have terrible reporting facilities on all Linux
filesystems.  btrfs is not inconsistent here.

> Other filesystems can get around this by not supporting multiple devices and
> relying on underlying systems (e.g. software or hardware raid) to make the
> disks appear a single device.

Indeed, this is contributing to the difference between your expectations
and reality.

> I do think btrfs would need more robust error handling for such cases -
> I don't know *any* raid implementation that ignores write errors, for
> example, and I don't think there is any raid implementation that ignores
> missing disks.

Most RAID implementations have a mode that allows data recovery when the
array has exceeded maximum tolerated failures (e.g. lvm "partial" mode,
or mdadm --force --run).  This is currently the only mode btrfs has.
Until we get some better management tools (kick a device out of the
array, reintegrate a previously disconnected device into an aray, all
while online) we're stuck permanently in partial mode.

> > failures even on the stuff btrfs does well?  e.g. there should not have
> > been a directory search problem at _any_ time with that setup.
> 
> That was my expectation, although I am well aware that this is still under
> development. I am already positively surprised that I was able to get an
> (apparently) fully functional filesystem back after something so drastic,
> with relatively little effort (metadata profile conversion).

RAID1 passed my test cases for the first time in 2016 (after some NULL
deref bugs were fixed).  If it's not working today, there has been
a _regression_.

> Tooling is not so much of an issue for me, the biggest issue would be
> detecting which files are on the missing disk, and if I can't come up with
> something better (e.g. ioctls to query the data block location), I can
> always read all files and see which of them error out and restore them.
> 
> > (*) Read errors are super important though--even the ones not reported
> > to userspace--as they are direct evidence of drive failure.
> 
> Under what conditions are write errors not even more direct evidence
> of drive failure (usually, but not exclusively, indicating far bigger
> problems than single block errors)?

Well, this is why you monitor dev stats for write errors (or, for
that matter, the raw disk devices).  The monitor can remount the
filesystem read-only or kill all the applications with open files if
that's what you'd prefer.

> > Since 5.0, btrfs silently ignores some of those, and this even got
> > backported to 4.19 and earlier LTS kernels. >:-(
> 
> eh, cool, uh :)
> 
> Well, I assume that my case of concern - single disk failure - is not
> something that will escape my attention forever, so doing a manual
> metadata balance is fully viable for me.

Remember that data-single metadata-raid1 is a weird case--you're
essentially saying that if a disk fails, you want the filesystem to be
read-only forever (btrfs won't mount it read-write without the missing
disk), and you don't care about which data disappears (since there's
no facility to control which files go on which disks).  I'd say being
confused about when Linux decides to return to EIO to userspace--already
well understood on other filesystems--is the least of your problems.  ;)

> My concern is merely that btrfs stubbornly insists a completely missing
> disk is totally fine to write to, essentially forever :)

That's an administrator decision, but btrfs does currently lack the tool
to implement the "remove the failing device" decision.  A workaround is
'echo 1 > /sys/block/sdX/dev/delete'.

> I'm not saying alerting userspace is required in some way. But maybe
> btrfs should not consider an obviously badly broken disk as healthy. I
> would have expected btrfs to stop writing to a disk when it is told in no
> unclear terms that the write failed, at leats at some point.

The trouble is that it's a continuum--disks aren't "good" at 0 errors
and "bad" at 1 or write errors.  Even mdadm isn't that strict--they have
maximum error counts, retries, mechanisms to do partial resyncs if disks
come back.  In btrfs this is all block-level stuff, every individual
block has its own sync state and data integrity.

lvm completely ignores _read_ errors during pvmove, a feature I use to
expedite the recovery of broken filesystems (and btrfs ends up not even
being broken).

> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
