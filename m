Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29241C2990
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 06:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgECEQW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 3 May 2020 00:16:22 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:32944 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgECEQV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 May 2020 00:16:21 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6E4736A19D8; Sun,  3 May 2020 00:16:19 -0400 (EDT)
Date:   Sun, 3 May 2020 00:16:19 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200503041619.GD10796@hungrycats.org>
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org>
 <20200428181436.GA5402@schmorp.de>
 <20200428213551.GC10796@hungrycats.org>
 <20200501015520.GA8491@schmorp.de>
 <20200501033720.GF10769@hungrycats.org>
 <20200502182316.GD1069@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200502182316.GD1069@schmorp.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 02, 2020 at 08:23:16PM +0200, Marc Lehmann wrote:
> On Thu, Apr 30, 2020 at 11:37:20PM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > > Well, the data wasn't raid1, but single, and no error was ever reported.
> > 
> > The metadata was raid1, that's all that should matter.
> 
> So, in other words, btrfs is a filesystem for metadata only and doesn't
> care about file data.

delalloc means applications don't get to learn about write errors
unless they jump through hoops.  If your application doesn't request
this information then it's correct for the application not to have it.
If your application _does_ request this information (via fsync, or mount
-o sync), and btrfs doesn't provide it, it's a bug.  btrfs doesn't do
anything about data block write errors beyond reporting them to userspace
when asked.  This is the same as any other filesystem on Linux.  You
just haven't been paying attention.

So that leaves only metadata that btrfs would or should do anything
about by its own initiative.  Other filesystems on Linux that support the
'errors=' mount option behave the same way--they won't stop for a data
block IO error, but they'll optionally panic the entire system for a
metadata block IO error.

> > > My concern is that btrfs will happily, continously and mostly silently loose
> > > data practically forever by assuming a disk that gives an error on every
> > > access is still there and able to hold data.
> > > 
> > > That behaviour is very different to other "raid" implementations.
> > 
> > Be careful what you ask for:  you have configured a filesystem that can
> > tolerate metadata write failures (raid1 insists on continuous operation
> > in degraded mode).  Fine, btrfs checks for metadata write failures, and
> > handles them by forcing itself read-only.
> 
> I'm quite sure I didn't ask for that. And I'm quite ok with how the
> metadata was handled.
>
> > those errors.  So it's going to tolerate all the failures in metadata
> > because that's what you asked for, and ignore all the failures in data
> > because that's what you asked for.
> 
> Well, that's clearly unlike any other filesystem/raid/etc. system out
> there.  Maybe this should then be pointed out more clearly, as people
> probablöy go towards btrfs with a similar attitude as existing systems.
> 
> > If your applications didn't call fsync() or use O_SYNC or O_DIRECT or
> > any of the other weird and wonderful ways to ask the filesystem to tell
> > you about data block write errors, then userspace won't learn anything
> > about data block write errors on most Linux filesystems.  The system
> > calls will exit before the disk is even touched, so there's no way to
> > tell the application that a delalloc extent write, which maybe happens
> > 30 seconds after the application closed the file, didn't work.  Nor is it
> > reasonable to shut down the entire filesystem because of a deferred
> > non-metadata write failure (well, maybe it's reasonable if btrfs had a
> > 'errors=remount-ro' option like ext4's).
> 
> I fully agree, that's why I suggested a policy more like other existign
> systems: declare the faulty disk as faulty.

This would not change anything in your case.

> > If you contrive a test case where other filesystems are able to write
> > their metadata without error, but all data block writes (excluding
> > directory block writes) fail with EIO, they will do the same thing as btrfs.
> 
> That's not a useful comparison, as the failure cased being discussed
> (device failure) is an all or nothing with those, as they don't manage
> multiple devices and rely on unerlying mechanisms (such as md) to do tha
> faulty device management.

OK, suppose we import what mdadm does in this case.  Result: no change.

> > It's a simple experiment with a USB stick (make sure to defeat your distro
> > which might be mounting with 'sync'):  write a multi-megabyte file to a
> > filesystem on the USB stick with 'cat', and let cat finish the write and
> > close the file without error.  Then immediately pull the USB stick out
> > before writeback starts.  Result:  the application sees write success,
> > the file is gone (or, depending on the filesystem, contains garbage),
> > and the only indication of failure is a handful of kernel messages about
> > the lost USB device.
> 
> Yes, I understand that perfectly, as I have initially explained...

I kind of think you don't, since you keep demonstrating that you don't
understand how every Linux filesystem behaves when it sees data block
write errors on delalloc block writes, nor do you understand what
mdadm and other raid systems do with JBOD and other non-redundant
configurations.

You keep expecting raid1 behaviors from single data.  That doesn't
make sense.  The whole point of single data is that it behaves like
data on other single-device filesystems and filesystems on top of JBOD
devices, not like data on a RAID1 device.  If you expect RAID1 behavior,
use raid1 data on btrfs.  It's your choice, you formatted your filesystem
with single data profile.

> > Other "raid" implementations for the most part don't support "care about
> > some data but not others" operating modes like the ones btrfs has.
> 
> Sure - since those other raids do not support distinguishing data they
> care for all data, not just metadata as btrfs does at the moment. I.e. it
> doesn't matter whether the data written is metadata or file data, a faulty
> device will be detected at some point.

Faulty devices in btrfs can be detected from dev stats.  It's what
dev stats are for.  A daemon can easily be set up to fire off a btrfs
replace on a spare drive if one of your data disks has write errors.

In your case you used single data profile, so all you can get from a
monitoring daemon is an email telling you that some of your data is
definitely gone now.

> > configuration.  Each profile is operating correctly according to its
> > rules, even if the combination of those rules doesn't make much sense
> > in terms of real-world use cases.
> 
> As I said, no hardware raid controller I know acts like btrfs "in the real
> world", and neither do most software raids. Neither did the linux block
> layer in the case at hand, by disallowing writes to the device forever,
> raid or not - just unplug the USB stick from your example and plug it in
> again - linux will not continue to write to it.

Every single-disk interface with persistent bus enumeration keeps the
device attached to its dev node.  mdadm does not kick a device out of a
JBOD array because of a write error--this would make the entire filesystem
instantly inaccessible.  Neither do most (all?) SATA interfaces, even if
the device drops off the bus and returns later.  USB can be configured to
do it as well, though USB is unreliable enough that it's dangerous to
enable this by default.

For RAID arrays with redundancy, some controllers and mdadm will kick
individual disks out of arrays _if they can continue to run in degraded
mode without the disk_.  Since you are using 'single' data, the number
of disks you can kick out of the array is zero.  Even if btrfs had a
full copy of the mdadm feature, it would behave _exactly_ the
same way it does now.

> The issue here is that btrfs behaves very differenmtly than other, similar,
> real-world systems, and the behaviour clearly makes no sense.
> 
> So, sure, btrfs can create rules that make no sense and apply them, but my
> whole point is that improving the rules so that they actually make sense is a
> worthwile goal.
> 
> > > I don't think my case is very unlikely - it's basically how linux behaves
> > > when lvm is used and, say, one of your disks has a temporary outage - the
> > > device node might go away and all accesses will rersult in EIO.
> > 
> > Were the read accesses not returning EIO?  That would be a bug.
> 
> Every access returned EIO (from the blocklayer), and I assume, but haven't
> investigated, that btrfs passed these through.
> 
> > Asynchronous writes have terrible reporting facilities on all Linux
> > filesystems.  btrfs is not inconsistent here.
> 
> Ah, but is - other filesystems will effectively stop writing to the disk
> in these cases (arguably not because they contain code to do so, the block
> layer forces this on them). 

This is not correct.  Other filesystems strictly stop writing to the
disk if there are _critical_ (meaning metadata) IO failures.  Data errors
(read or write) are only reported to userspace, and if userspace doesn't
stick around to get the write error status, nobody gets notified about
the lost data.

The block layer only forces a disconnect if the device disconnects.  If
the device stays online but rejects every write request with an error,
then filesystems will keep submitting write requests until they are forced
readonly because of a metadata update failure.

> The difference is that other filesystems do not
> contain a device manager for multiple devices, so they can let the kernel or
> other underlying syytems do the disk management.
> 
> btrfs can do the disk management itself, but fails to do so in a
> reasonable way for missing disks.
> 
> > > Other filesystems can get around this by not supporting multiple devices and
> > > relying on underlying systems (e.g. software or hardware raid) to make the
> > > disks appear a single device.
> > 
> > Indeed, this is contributing to the difference between your expectations
> > and reality.
> 
> Yes, that's why I tghinbk btrfs would be improved by kicking faulty disks
> out of it's filesystem, versus continuing to use it as it if still was
> there.

Still different expectations and reality.

> > > I do think btrfs would need more robust error handling for such cases -
> > > I don't know *any* raid implementation that ignores write errors, for
> > > example, and I don't think there is any raid implementation that ignores
> > > missing disks.
> > 
> > Most RAID implementations have a mode that allows data recovery when the
> > array has exceeded maximum tolerated failures (e.g. lvm "partial" mode,
> > or mdadm --force --run).  This is currently the only mode btrfs has.
> 
> I wish - btrfs simply ignored the missing disk and continued on.
> 
> > Until we get some better management tools (kick a device out of the
> > array, reintegrate a previously disconnected device into an aray, all
> > while online) we're stuck permanently in partial mode.
> 
> I'm not sure how exactly you define partial mode - lvm and mdraid both
> define it as missing "disks".

Yes.  In btrfs, chunks from different disks are gathered into block
groups.  The RAID profiles work on the block group level, as if you
had made thousands of partitions and then used mdadm to assemble each
pair of partitions into arrays with different profiles.

If there are block groups anywhere in your btrfs where too many disks are
missing (i.e. for single data, if one disk is missing), your filesystem
will be read-only, and you'll be able to read any data that is still
available on remaining disks.  This doesn't happen immediately--disks
fall of the bus and reconnect sometimes--but if you umount the filesystem
and mount it again, you will be in degraded mode because of the missing
disk, and strictly read-only because single profile tolerates zero
disk failures.  If you are not able to recover the missing disk then
you will have to mkfs and copy the surviving data to a freshly formatted
filesystem.

This is equivalent to the lvm partial and mdadm recovery modes, though
I believe they still allow write access.

It would be nice if btrfs could allow read-write mode here, so you can
delete all your damaged files and then remove the failed disk; however,
currently it doesn't do that, and simply removing the check for missing
disks isn't enough to fix it (I've already tried that ;).

> That's clearly not what btrfs does - btrfs didn't go into any partial
> mode, it simply continued on pretending the disk is fine.
> 
> > > That was my expectation, although I am well aware that this is still under
> > > development. I am already positively surprised that I was able to get an
> > > (apparently) fully functional filesystem back after something so drastic,
> > > with relatively little effort (metadata profile conversion).
> > 
> > RAID1 passed my test cases for the first time in 2016 (after some NULL
> > deref bugs were fixed).  If it's not working today, there has been
> > a _regression_.
> 
> That's good to hear - however, the really useful improvements (for this
> case) were not in btrfs raid1, but in the fact that btrfs recently got
> a lot more picky about treating errors as raid-errors (e.g. parwent
> transid msimatches), and thus using the mirrored information a lot more
> aggressive.
> 
> That's what allowed it to recover from having being presented an old
> evrsion of a member disk.
> 
> > > Under what conditions are write errors not even more direct evidence
> > > of drive failure (usually, but not exclusively, indicating far bigger
> > > problems than single block errors)?
> > 
> > Well, this is why you monitor dev stats for write errors (or, for
> > that matter, the raw disk devices).  The monitor can remount the
> > filesystem read-only or kill all the applications with open files if
> > that's what you'd prefer.
> 
> Well, if that is allk that btrfs can do, that's how it has to be done, of
> course.
> 
> It would clearly be better (and probably trivial) in my eyes if btrfs
> would act more like all the other systems out there and limit the amount
> of data loss, but I'm not a btrfs dveeloper, so I take what I get :)
> 
> > > Well, I assume that my case of concern - single disk failure - is not
> > > something that will escape my attention forever, so doing a manual
> > > metadata balance is fully viable for me.
> >
> > Remember that data-single metadata-raid1 is a weird case--you're
> > essentially saying that if a disk fails, you want the filesystem to be
> > read-only forever (btrfs won't mount it read-write without the missing
> > disk)
> 
> It doesn't feel weird to me - it seems the only way of limiting data loss.
> With metadata=raid1, the filesystem will survive a single device loss, with
> some work. With metadata=single, it almost certainly won't.
> 
> I currently have a single multi-device filesystem for archival, and it
> keeps acquiring disks (it's currently at 7 devices). Sinmgle device
> failures are a almost guaramteed during the lfietime of the fs, and being
> able to recover from that without losing all data and with being able to
> restore only the missing data seems not so weird to me.
> 
> Also, I didn't want btrfs to be read-only, but that would probably be
> preferable over the current behaviour, as it would limit data loss.

OK, so you've gotten stuck on a trivial side issue, and missed the fact
that your entire plan does not work.

Single data means if you lose any disk (with data on it) then the
filesystem will be forced read-only and you have to start over with a
new filesystem.  You'll need raid1, raid5, or raid6 (or raid10, why not)
to survive disk failures; otherwise, the entire filesystem stops when
any disk is not available at mount time.  Here, all raid1 metadata does
for you is give you the same protection against bitrot and bad sectors
that dup metadata does.  The advantage of raid1 metadata is that raid1 is
faster than dup.  It's still fundamentally a filesystem on top of JBOD,
and it behaves exactly as such.

The partial recovery you speak of only works with sector-level errors
(UNC sectors and csum failures).  I suppose if you restore the superblocks
of missing disks onto a new disk, you could fool btrfs into thinking the
entire disk is still online, then use scrub to recover the metadata, then
delete all the broken files, but you may find the results disappointing.

Even when mounted read-only, 1/7 of the data extents are gone, so files
will be damaged according to their size:  14% of files 4K and smaller will
be 100% destroyed, 100% of files over 7GB will be missing at least 14% of
their contents, files between those sizes will have various probabilities
and quantities of loss in between.

Depending on how your file sizes are
distributed, you might keep 10-20% of the files intact, which is better
than 0%, but it's very unlikely you'll get anything close to 86%.

raid5 data, despite the bugs, costs only one drive's worth of capacity
(the largest one) and can recover from losing a disk.  Be sure to use
space_cache=v2 and raid1 metadata with raid5 data (space_cache=v1 is
stored in data blocks and can be corrupted when used with raid5, and
raid5 metadata has two other filesystem-killing problems).

With _major_ surgery in the delalloc write handling, btrfs could detect
that one disk is producing write errors, and relocate the data to a
remaining disk with free space in single profile block groups, and try
the write again; however, the cost of that work would be paid in years
of regression fixes, and the gains achieved would be very small, like
having only 75% of a filesystem damaged by a single-disk failure instead
of 80%, or having all but the most critical 30 seconds of a log file
as a disk fails.

> > and you don't care about which data disappears (since there's
> > no facility to control which files go on which disks).  I'd say being
> > confused about when Linux decides to return to EIO to userspace--already
> > well understood on other filesystems--is the least of your problems. ;)
> 
> I'm not sure how to hanmdle this case better, other than using actual raid.
> 
> I'm still not sure why you think this is weird, though - btrfs itself has
> a "dup" mode which also suffers from the same problems (no facility to
> control where the copy of the blocks go), and with single profile on a
> single disk (the most common case), device lsos means total data loss.
> 
> Why is it so weird to try to limit data loss and restore costs? What's
> the point of the dup profile if not the same (limit data loss on partial
> failure)?

It's weird because single data does not limit data loss or restore costs.
At most, single data can reliably report data loss after the fact.
After a failure, you'll need 6 new drives to copy the shattered remains
of your filesystem to, and it might be cheaper to buy an 8th disk today
for RAID5.

The "raid1" in the raid1 metadata doesn't help you survive disk failures.
It's just a faster version of dup metadata for 2 or more drives, with
all the same failure modes.

> If dup is so weird, why is it beign used by default in some cases in
> btfrs?

dup isn't weird on single-disk filesystems.  There are many more
individual sector errors and silent corruption on single disks than
there are total disk failures, and dup profile can fix most of them.
dup metadata is essential on cheap SSDs since silent data corruption is
their most common failure mode.

It's a bit unfortunate that btrfs's default is still to use single
metadata on SSD--it's going to eat a lot of filesystems on low-end
machines.

> > > My concern is merely that btrfs stubbornly insists a completely
> > > missing disk is totally fine to write to, essentially forever :)
> >
> > That's an administrator decision, but btrfs does currently lack the tool
> > to implement the "remove the failing device" decision.  A workaround is
> > 'echo 1 > /sys/block/sdX/dev/delete'.
> 
> Well, the tool (that does the deciwsion) should obviously be inside the
> kernel, not userspace, because currently, I, as an administrator, cannot
> make that decision and it would be necessarily delayed.
> 
> Intersstignly enough, it's not an administrative decision with other,
> similar, systems - the linux kernel doesn't allow me to configure the
> current btrfs failure, and neither do software and hardware raids - they
> all kick out faulty devices automatically at some point.
> 
> > > I'm not saying alerting userspace is required in some way. But maybe
> > > btrfs should not consider an obviously badly broken disk as healthy. I
> > > would have expected btrfs to stop writing to a disk when it is told in
> > > no unclear terms that the write failed, at leats at some point.
> >
> > The trouble is that it's a continuum--disks aren't "good" at 0 errors
> > and "bad" at 1 or write errors.  Even mdadm isn't that strict--they have
> > maximum error counts, retries, mechanisms to do partial resyncs if disks
> > come back.  In btrfs this is all block-level stuff, every individual
> > block has its own sync state and data integrity.
> 
> The problem is thta btrfs has a maximum, unconfgiurable, error count of
> infinity.
> 
> I'd be totally happy with an unconfigurable error count of "0", "small",
> "bigger", or it being configurable :)
> 
> I tzhink you are misundestanding me - it seems we actually fully
> agree that the btrfs behaviour is bad as it is and would gain from
> improvement. 

The current behavior isn't wrong--none of the data integrity requirements
are violated.  Potential improvements in this area are mostly related
to not spamming the kernel log with errors from bad drives, and doing
something about disks that don't report errors and don't corrupt data,
but have suddenly become orders of magnitude slower.  It would be nice to
say "look I know you think sda is healthy, but get rid of it immediately"
to btrfs directly, as opposed to talking to the block layer underneath
and hoping it has a device delete function of some kind.

This is necessarily not automated kernel-side, unless we get some more
sophisticated primitives underneath (e.g. "migrate metadata to new disk"
or "replace with chunk tree relocation").  You definitely do not want to
throw btrfs metadata into degraded raid1 mode without soberly considering
the risk tradeoffs involved--that implies single metadata, and when that
happens, you are literally 1 wrong bit away from not having a filesystem
any more.  Proactive monitoring (or an automated script with a pool of
available spare drives to deploy for replacement) is essential.

> I'm not proposing any fixed solution, other than having
> *some* rsasonable kind of data loss limiting inside btrfs, at elast in
> obvious cases.
> 
> > lvm completely ignores _read_ errors during pvmove, a feature I use to
> > expedite the recovery of broken filesystems (and btrfs ends up not even
> > being broken).
> 
> That's interesting - last time I used pvmove on a source with read errors,
> it didn't move that (that was a hwile ago, most of my volumes nowadays are
> raid5'ed and don't suffer from read errors).

Interesting, I've never seen it stop.  I've pvmoved plenty of LVs from
half-broken drives (UNC remapping table full).  If it didn't work,
I'd have to create a new LV on a new PV and then use dd_rescue to copy
the data--but I've never had to do that, pvmove just plows through as
megabytes of IO errors scroll by on dmesg.  There are plenty of error
counters in sysfs that increment while this happens, but nothing ever
seems to check them.

> More importantly, however, if your source drive fails, pvmove will *not*
> end up with skipping all the rest of the transfer and finish successfully
> (as btrfs did in the case we discuss), resulting in very massive data
> loss, simply because it cannot commit the new state.

lvm copies the remaining data, and then reports success (well, it doesn't
report anything per se, it just finishes the operation and updates the VG
config when it's done).  Obviously the data is garbage in the unreadable
blocks, but a scrub fixes that.

> No matter what other tool you look at, none behave as btrfs does
> currently. Actual behaviour difers widely in detail, of course, but I
> can't come up with a situation where a removed disk will result in upper
> layers continuing to use it as if it were there.

See lvm.conf, activation_mode "partial":

        #   partial
        #     Allows the activation of any LV even if a missing or failed PV
        #     could cause data loss with a portion of the LV inaccessible.

You can run an ext4 FS on top of a LV with missing PVs.  It behaves mostly
the same way that btrfs does--ignores write errors on data blocks other
than reporting them to the application, and keeps going until it hits
an IO error on a metadata update.  This part of what btrfs does isn't
the incorrect part--or if it is, then all the other filesystems on Linux
are wrong too.

> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
