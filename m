Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3211C2787
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgEBSXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 14:23:20 -0400
Received: from mail.nethype.de ([5.9.56.24]:40437 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbgEBSXU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 14:23:20 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jUwnE-002Wg6-Mp; Sat, 02 May 2020 18:23:16 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jUwnE-0005Cz-IK; Sat, 02 May 2020 18:23:16 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jUwnE-0001Nd-H9; Sat, 02 May 2020 20:23:16 +0200
Date:   Sat, 2 May 2020 20:23:16 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200502182316.GD1069@schmorp.de>
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org>
 <20200428181436.GA5402@schmorp.de>
 <20200428213551.GC10796@hungrycats.org>
 <20200501015520.GA8491@schmorp.de>
 <20200501033720.GF10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200501033720.GF10769@hungrycats.org>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 11:37:20PM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > Well, the data wasn't raid1, but single, and no error was ever reported.
> 
> The metadata was raid1, that's all that should matter.

So, in other words, btrfs is a filesystem for metadata only and doesn't
care about file data.

> > My concern is that btrfs will happily, continously and mostly silently loose
> > data practically forever by assuming a disk that gives an error on every
> > access is still there and able to hold data.
> > 
> > That behaviour is very different to other "raid" implementations.
> 
> Be careful what you ask for:  you have configured a filesystem that can
> tolerate metadata write failures (raid1 insists on continuous operation
> in degraded mode).  Fine, btrfs checks for metadata write failures, and
> handles them by forcing itself read-only.

I'm quite sure I didn't ask for that. And I'm quite ok with how the
metadata was handled.

> those errors.  So it's going to tolerate all the failures in metadata
> because that's what you asked for, and ignore all the failures in data
> because that's what you asked for.

Well, that's clearly unlike any other filesystem/raid/etc. system out
there.  Maybe this should then be pointed out more clearly, as people
probablöy go towards btrfs with a similar attitude as existing systems.

> If your applications didn't call fsync() or use O_SYNC or O_DIRECT or
> any of the other weird and wonderful ways to ask the filesystem to tell
> you about data block write errors, then userspace won't learn anything
> about data block write errors on most Linux filesystems.  The system
> calls will exit before the disk is even touched, so there's no way to
> tell the application that a delalloc extent write, which maybe happens
> 30 seconds after the application closed the file, didn't work.  Nor is it
> reasonable to shut down the entire filesystem because of a deferred
> non-metadata write failure (well, maybe it's reasonable if btrfs had a
> 'errors=remount-ro' option like ext4's).

I fully agree, that's why I suggested a policy more like other existign
systems: declare the faulty disk as faulty.

> If you contrive a test case where other filesystems are able to write
> their metadata without error, but all data block writes (excluding
> directory block writes) fail with EIO, they will do the same thing as btrfs.

That's not a useful comparison, as the failure cased being discussed
(device failure) is an all or nothing with those, as they don't manage
multiple devices and rely on unerlying mechanisms (such as md) to do tha
faulty device management.

> It's a simple experiment with a USB stick (make sure to defeat your distro
> which might be mounting with 'sync'):  write a multi-megabyte file to a
> filesystem on the USB stick with 'cat', and let cat finish the write and
> close the file without error.  Then immediately pull the USB stick out
> before writeback starts.  Result:  the application sees write success,
> the file is gone (or, depending on the filesystem, contains garbage),
> and the only indication of failure is a handful of kernel messages about
> the lost USB device.

Yes, I understand that perfectly, as I have initially explained...

> Other "raid" implementations for the most part don't support "care about
> some data but not others" operating modes like the ones btrfs has.

Sure - since those other raids do not support distinguishing data they
care for all data, not just metadata as btrfs does at the moment. I.e. it
doesn't matter whether the data written is metadata or file data, a faulty
device will be detected at some point.

> configuration.  Each profile is operating correctly according to its
> rules, even if the combination of those rules doesn't make much sense
> in terms of real-world use cases.

As I said, no hardware raid controller I know acts like btrfs "in the real
world", and neither do most software raids. Neither did the linux block
layer in the case at hand, by disallowing writes to the device forever,
raid or not - just unplug the USB stick from your example and plug it in
again - linux will not continue to write to it.

The issue here is that btrfs behaves very differenmtly than other, similar,
real-world systems, and the behaviour clearly makes no sense.

So, sure, btrfs can create rules that make no sense and apply them, but my
whole point is that improving the rules so that they actually make sense is a
worthwile goal.

> > I don't think my case is very unlikely - it's basically how linux behaves
> > when lvm is used and, say, one of your disks has a temporary outage - the
> > device node might go away and all accesses will rersult in EIO.
> 
> Were the read accesses not returning EIO?  That would be a bug.

Every access returned EIO (from the blocklayer), and I assume, but haven't
investigated, that btrfs passed these through.

> Asynchronous writes have terrible reporting facilities on all Linux
> filesystems.  btrfs is not inconsistent here.

Ah, but is - other filesystems will effectively stop writing to the disk
in these cases (arguably not because they contain code to do so, the block
layer forces this on them). The difference is that other filesystems do not
contain a device manager for multiple devices, so they can let the kernel or
other underlying syytems do the disk management.

btrfs can do the disk management itself, but fails to do so in a
reasonable way for missing disks.

> > Other filesystems can get around this by not supporting multiple devices and
> > relying on underlying systems (e.g. software or hardware raid) to make the
> > disks appear a single device.
> 
> Indeed, this is contributing to the difference between your expectations
> and reality.

Yes, that's why I tghinbk btrfs would be improved by kicking faulty disks
out of it's filesystem, versus continuing to use it as it if still was
there.

> > I do think btrfs would need more robust error handling for such cases -
> > I don't know *any* raid implementation that ignores write errors, for
> > example, and I don't think there is any raid implementation that ignores
> > missing disks.
> 
> Most RAID implementations have a mode that allows data recovery when the
> array has exceeded maximum tolerated failures (e.g. lvm "partial" mode,
> or mdadm --force --run).  This is currently the only mode btrfs has.

I wish - btrfs simply ignored the missing disk and continued on.

> Until we get some better management tools (kick a device out of the
> array, reintegrate a previously disconnected device into an aray, all
> while online) we're stuck permanently in partial mode.

I'm not sure how exactly you define partial mode - lvm and mdraid both
define it as missing "disks".

That's clearly not what btrfs does - btrfs didn't go into any partial
mode, it simply continued on pretending the disk is fine.

> > That was my expectation, although I am well aware that this is still under
> > development. I am already positively surprised that I was able to get an
> > (apparently) fully functional filesystem back after something so drastic,
> > with relatively little effort (metadata profile conversion).
> 
> RAID1 passed my test cases for the first time in 2016 (after some NULL
> deref bugs were fixed).  If it's not working today, there has been
> a _regression_.

That's good to hear - however, the really useful improvements (for this
case) were not in btrfs raid1, but in the fact that btrfs recently got
a lot more picky about treating errors as raid-errors (e.g. parwent
transid msimatches), and thus using the mirrored information a lot more
aggressive.

That's what allowed it to recover from having being presented an old
evrsion of a member disk.

> > Under what conditions are write errors not even more direct evidence
> > of drive failure (usually, but not exclusively, indicating far bigger
> > problems than single block errors)?
> 
> Well, this is why you monitor dev stats for write errors (or, for
> that matter, the raw disk devices).  The monitor can remount the
> filesystem read-only or kill all the applications with open files if
> that's what you'd prefer.

Well, if that is allk that btrfs can do, that's how it has to be done, of
course.

It would clearly be better (and probably trivial) in my eyes if btrfs
would act more like all the other systems out there and limit the amount
of data loss, but I'm not a btrfs dveeloper, so I take what I get :)

> > Well, I assume that my case of concern - single disk failure - is not
> > something that will escape my attention forever, so doing a manual
> > metadata balance is fully viable for me.
>
> Remember that data-single metadata-raid1 is a weird case--you're
> essentially saying that if a disk fails, you want the filesystem to be
> read-only forever (btrfs won't mount it read-write without the missing
> disk)

It doesn't feel weird to me - it seems the only way of limiting data loss.
With metadata=raid1, the filesystem will survive a single device loss, with
some work. With metadata=single, it almost certainly won't.

I currently have a single multi-device filesystem for archival, and it
keeps acquiring disks (it's currently at 7 devices). Sinmgle device
failures are a almost guaramteed during the lfietime of the fs, and being
able to recover from that without losing all data and with being able to
restore only the missing data seems not so weird to me.

Also, I didn't want btrfs to be read-only, but that would probably be
preferable over the current behaviour, as it would limit data loss.

> and you don't care about which data disappears (since there's
> no facility to control which files go on which disks).  I'd say being
> confused about when Linux decides to return to EIO to userspace--already
> well understood on other filesystems--is the least of your problems. ;)

I'm not sure how to hanmdle this case better, other than using actual raid.

I'm still not sure why you think this is weird, though - btrfs itself has
a "dup" mode which also suffers from the same problems (no facility to
control where the copy of the blocks go), and with single profile on a
single disk (the most common case), device lsos means total data loss.

Why is it so weird to try to limit data loss and restore costs? What's
the point of the dup profile if not the same (limit data loss on partial
failure)?

If dup is so weird, why is it beign used by default in some cases in
btfrs?

> > My concern is merely that btrfs stubbornly insists a completely
> > missing disk is totally fine to write to, essentially forever :)
>
> That's an administrator decision, but btrfs does currently lack the tool
> to implement the "remove the failing device" decision.  A workaround is
> 'echo 1 > /sys/block/sdX/dev/delete'.

Well, the tool (that does the deciwsion) should obviously be inside the
kernel, not userspace, because currently, I, as an administrator, cannot
make that decision and it would be necessarily delayed.

Intersstignly enough, it's not an administrative decision with other,
similar, systems - the linux kernel doesn't allow me to configure the
current btrfs failure, and neither do software and hardware raids - they
all kick out faulty devices automatically at some point.

> > I'm not saying alerting userspace is required in some way. But maybe
> > btrfs should not consider an obviously badly broken disk as healthy. I
> > would have expected btrfs to stop writing to a disk when it is told in
> > no unclear terms that the write failed, at leats at some point.
>
> The trouble is that it's a continuum--disks aren't "good" at 0 errors
> and "bad" at 1 or write errors.  Even mdadm isn't that strict--they have
> maximum error counts, retries, mechanisms to do partial resyncs if disks
> come back.  In btrfs this is all block-level stuff, every individual
> block has its own sync state and data integrity.

The problem is thta btrfs has a maximum, unconfgiurable, error count of
infinity.

I'd be totally happy with an unconfigurable error count of "0", "small",
"bigger", or it being configurable :)

I tzhink you are misundestanding me - it seems we actually fully
agree that the btrfs behaviour is bad as it is and would gain from
improvement. I'm not proposing any fixed solution, other than having
*some* rsasonable kind of data loss limiting inside btrfs, at elast in
obvious cases.

> lvm completely ignores _read_ errors during pvmove, a feature I use to
> expedite the recovery of broken filesystems (and btrfs ends up not even
> being broken).

That's interesting - last time I used pvmove on a source with read errors,
it didn't move that (that was a hwile ago, most of my volumes nowadays are
raid5'ed and don't suffer from read errors).

More importantly, however, if your source drive fails, pvmove will *not*
end up with skipping all the rest of the transfer and finish successfully
(as btrfs did in the case we discuss), resulting in very massive data
loss, simply because it cannot commit the new state.

No matter what other tool you look at, none behave as btrfs does
currently. Actual behaviour difers widely in detail, of course, but I
can't come up with a situation where a removed disk will result in upper
layers continuing to use it as if it were there.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
