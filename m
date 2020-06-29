Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C418D20E915
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 01:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgF2XFR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 29 Jun 2020 19:05:17 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38436 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgF2XFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 19:05:16 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7711573C30E; Mon, 29 Jun 2020 19:05:14 -0400 (EDT)
Date:   Mon, 29 Jun 2020 19:05:14 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        Pablo Fabian Wagner Boian <pablofabian.wagnerboian@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Buggy disk firmware (fsync/FUA) and power-loss btrfs survability
Message-ID: <20200629230514.GY10769@hungrycats.org>
References: <CAK=moY9cRF0WKnBp5wRzFUuuL9=rJ8mD8uEA6murWEUYwvQkWw@mail.gmail.com>
 <f0144a34-f14a-5413-9b0c-a2ccba1a1cd9@knorrie.org>
 <2aaab8d7-a37d-8965-bd70-9ed7b0e80b0f@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2aaab8d7-a37d-8965-bd70-9ed7b0e80b0f@dirtcellar.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 29, 2020 at 02:15:07AM +0200, waxhead wrote:
> Hans van Kranenburg wrote:
> > Hi!
> > 
> > On 6/28/20 3:33 PM, Pablo Fabian Wagner Boian wrote:
> > > Hi.
> > > 
> > > Recently, it came to my knowledge that btrfs relies on disks honoring
> > > fsync. So, when a transaction is issued, all of the tree structure is
> > > updated (not in-place, bottom-up) and, lastly, the superblock is
> > > updated to point to the new tree generation. If reordering happens (or
> > > buggy firmware just drops its cache contents without updating the
> > > corresponding sectors) then a power-loss could render the filesystem
> > > unmountable.

The buggy firmware problem is trivial to work around: simply disable
write caching in the drive (e.g. hdparm -W0 in udev).  Problem goes away.
I've been running btrfs on old WD drives with firmware bugs for years.

It's fairly easy to test drives for buggy write cache firmware:
mkfs.btrfs, start writing data, start a metadata balance, run sync
in a while loop, disconnect power, repeat about 20 times, see if the
filesystem still mounts.  It only takes a few hours to find a bad
firmware.  SMART long self-tests take longer.

Some admins assume all firmware is buggy and preemptively turn off write
cache on all drives.  I don't think that approach is well supported
by the data.  I tested 100+ drive models, and found only 4 with write
cache bugs.  Pick any random pair of drive models for raid1, and there's a
99%+ chance that at least one of them has working firmware.  The good
drive can carry the filesystem even if the other drive has bad firmware.
If the raid1 array goes into degraded mode, temporarily turn off write
cache on the surviving drive until the failed drive is replaced.

There are several firmware issues that can make a drive unfit for purpose.
Not all of these are write caching or even data integrity bugs.  If you
are deploying at scale, assume 10% of the drive models you'll test
are unusable due to assorted firmware issues.  Less than half of these
are write cache bugs--the rest are other data integrity bugs, firmware
crashing bugs, and crippling performance issues triggered by specific
application workloads.  Plan vendor qualification tests and product
QA accordingly.  Plan for common mode failure risks when designing
storage redundancy.

For the following, I'll assume that for some reason you're going to insist
on enabling the write cache on a drive with possibly buggy firmware and
you have not managed the risks in some better way, and then just see
where that absurd premise goes.

> > > Upon more reading, ZFS seems to implement a circular buffer in which
> > > new pointers are updated one after another. That means that, if older
> > > generations (in btrfs terminology) of the tree are kept on disk you
> > > could survive such situations by just using another (older) pointer.
> > 
> > Btrfs does not keep older generations of trees on disk. *) Immediately
> > after completing a transaction, the space that was used by the previous
> > metadata can be overwritten again. IIRC when using the discard mount
> > options, it's even directly freed up on disk level by unallocating the
> > physical space by e.g. the FTL in an SSD. So, even while not overwritten
> > yet, reading it back gives you zeros.
> > 
> > *) Well, only for fs trees, and only if you explicitly ask for it, when
> > making subvolume snapshots/clones.
> > So just out of curiosity... if BTRFS internally at every successful
> mount did a 'btrfs subvolume create /mountpoint /mountpoint/fsbackup1' you
> would always have a good filesystem tree to fall back to?! would this be
> correct?!
> 
> And if so - this would mean that you would loose everything that happened
> since last mount, but compared to having a catastrophic failure this sound
> much much better.

This would also imply that you cannot delete _anything_ in the filesystem
between mounts.  Without some kind of working write barrier, you can
only append new data to the filesystem.  No sector can ever move from
an occupied state to an unoccupied state, because you might not have
successfully removed all references to the occupied sector (*).  If there
are no working write barriers, you don't know if any write was complete
or successful, so you have to assume any write could have failed.

(*) OK you could do that with ext2, but ext2 had potential data loss
and had to run full fsck after _every_ crash.  Not a model for btrfs
to follow.

In effect, you've got a single write barrier event during the mount,
in the sense that the filesystem has freshly booted, and there are no
earlier writes that could possibly be waiting to complete in the drive's
write cache.  Since the drive firmware is buggy, we can't get working
write barriers from the drive itself.  The only way we get another
reliable write barrier is to power off the drive, power it back on,
check and mount the filesystem again.  umounting and mounting are not
sufficient because those rely on properly functioning write barriers
to work.  We power off the drive to make sure its firmware isn't giving
us good data from its volatile RAM cache instead of bad data from the
disk--if the drive did that, then our mount test would pass, but the
data on the disk could be broken, and we wouldn't discover this until
it was too late to recover.  If we power off the drive, we might wipe
its volatile write cache before its contents are written to disk (no
working barrier means we can't prevent that), so we have to verify the
filesystem on the following mount to make sure we haven't lost any writes,
or recover if we have.

If we don't have working write barriers, can we fake them?

Write caching firmware bugs come in two forms:  reordering, and lost
writes.  To btrfs, they both look like ordinary data corruption on the
disk, except that when the corruption is caused by write caching, it
breaks writes that occur at close to the same time (e.g. both mirrored
copies of dup metadata on btrfs).  This make the data loss unrecoverable
by the normal methods btrfs uses to recover from metadata loss.  Compare
with an ordinary bad sector:  btrfs separates dup metadata by a gigabyte
of disk surface, so (on spinning disks) there is some physical distance
between metadata copies, and a few bad sectors will damage only one copy.

The lost writes case is where the drive silently loses the contents of
its write cache after notifying the host that the data was written to disk
successfully (e.g. due to a hardware fault combined with a firmware bug).
In this case the filesystem has been damaged, and the host does not know
that this damage has occurred until the next time btrfs tries to read the
lost data.  The standard way to recover from lost metadata is to keep
two copies in dup metadata block groups, but write caching bugs will
destroy both copies because they are written at close to the same time.

We can increase the time between writes of duplicate copies of data,
but this dramatically increases kernel memory usage.  You'll need enough
RAM to separate writes by enough time to _maybe_ have the write cache get
flushed, assuming that's possible at all on a drive with buggy firmware.
At 500 MB/s, even a few seconds of delay is a lot of RAM.  If you don't
have enough RAM, you have to throttle the filesystem so that the amount
of RAM you do have provides you with enough buffering time.

The reordering case is the one that happens when there's a power failure.
The drive is told by the host to write block A, then B, then C, but
instead the drive writes C, then B, then A.  This is OK as long as the
drive does eventually write all 3 blocks, and as long as at some point a
tree--and its shared pages referenced from all earlier versions of the
tree--is completely written on the disk, with no overwrites from later
transactions.  Without write barriers, the drive might constantly start
writes on new transaction trees without finishing old ones.  After a
crash we might have to rewind all the way back to the previous mount to
find an intact tree.

If the firmware is freed of the requirement to respect write ordering,
then it can indefinitely postpone any write, and its behavior is limited
only by physical constraints.  e.g. if the disk has 256MB RAM cache,
the firmware can't fake more than 256MB of data at a time--when the RAM
runs out, the firmware has to prove that it can read data that it has
written to the disk, or its lies will be exposed.  If we try to read any
sector we recently wrote, the drive can simply reply with the contents
of its RAM cache, so we can't verify the contents of the disk unless we
circumvent read caching as well.

We could try to defeat the drive firmware by brute force.  We make a
guess about the firmware's behavior wrt its constraints, e.g. after
50GB of reads and writes, we assume that a 256MB RAM cache running a
LRU-ish algorithm is thoroughly purged many times over, any earlier
writes are all safely on disk, and any future reads will return data
from the disk surface.

We could track how many writes btrfs did, and delete filesystem trees that
happened 50GB of writes ago.  But this guess could be wrong.  Some drives
will postpone writes indefinitely--if they receive a continuous series
of IO requests, they may never write some sectors from their write cache
at all, or they will prioritize linear multi-sector accesses over seeks
to update a single sector (like a root page, or the btrfs superblock)
and start writing several trees at once without completing any of them.
Never underestimate what a vendor will do to win a benchmark.

50GB of written data may not be sufficient--we might have to throttle
writes from the filesystem as well, to give the drive some idle time to
finish flushing its write cache.  Or the drive might drop 256MB somewhere
in the middle of that 50GB, and btrfs won't find out about the damage
until the next scrub.  So whether we are successful depends a lot on
how reliably we can predict how buggy drive firmware will behave, and
just how buggy the firmware is.

If we try to verify the contents of the disk by reading the data back,
we can fail badly if the drive implements an ARC-ish caching algorithm
instead of a LRU-ish one.  The drive might be able to successfully predict
our verification reads and keep their data in cache, so we don't get
accurate data about what is on disk.  We might delete a tree that is
not referenced in the drive's RAM cache but is referenced on disk.
The filesystem fails when the drive is reset because the drive can no
longer maintain the fiction of intact data on disk.

Another more straightforward way to brute-force a write cache purge is to
write hundreds of MB to random free blocks on the filesystem.  This could
be used to provide fsync()-like semantics, but without anything close
to normal fsync() performance, even with write caching disabled.

Another problem is that btrfs has physical constraints too.  If we
don't have 50GB of free space, our fake write barriers that rely on
writing 50GB of new data are no longer possible, but we urgently need
to delete something in part _because_ our fake write barriers are no
longer possible.  In the worst case (like a snapshot delete on a full
filesystem), we might end up doing multiple commits within a 256MB
write window, and at that point we no longer have even the fake write
barriers--all of our writes can be indefinitely postponed or reordered
in the drive's volatile RAM cache.  If there's a crash, boom, the
firmware bug ends the filesystem.  Even if the filesystem doesn't crash,
rolling back to a point in time where you had 50GB of free space more
than you do now--possibly all the way to the previous mount--can be
pretty rough.

> And if I as just a regular BTRFS user with my (possibly distorted) view see
> this, if you would leave the top level subvolume (5) untouched and avoid
> updates to this except creating child subvolues you reduce the risk of
> catastrophic failure in case a fsync does not work out as only the child
> subvolumes (that are regularily updated) would be at risk.
> 
> And if BTRFS internally made alternating snapshots of the root subvolumes
> (5)'s child subvolumes you would loose at maximum 30sec x 2 (or whatever the
> commit time is set to) of data.
> 
> E.g. keep only child subvolumes on the top level (5).
> And if we pretend the top level has a child subvolume called rootfs, then
> BTRFS could internally auto-snapshot (5)/rootfs every other time to
> (5)/rootfs_autobackup1 and (5)/rootfs_autobackup2
> 
> Do I understand this correctly or would there be any (significant)
> performance drawback to this? Quite frankly I assume it is or else I guess
> it would have been done already , but it never hurts (that much) to ask...

Usually when SHTF in the filesystem, it's the non-subvol trees that break
and ruin your day.  The extent tree is where all reference counting in all
of btrfs is done.  Broken extent trees are very hard to fix--you have to
walk all the subvol trees to recreate the extent tree, or YOLO fix them
one inconsistency at a time while the filesystem is running (hope the
reference count on a metadata page never reaches a negative number, or
you lose even more data very quickly!).  Small commits involve thousands
of extent tree updates.  Big ones do millions of updates.

I'm not sure off the top of my head whether the 300x write multiplier for
new snapshots would apply to a hypothetical snapshot of the extent tree,
but if it did, it would mean 300x write multipliers more or less all
of the time.  When a snapshot page is updated, the page is CoWed, but
also every reference to and backreference from the page is also CoWed.
Usually with snapshot subvols the write multiplier drops rapidly to 1x
on average after a few seconds of activity, but with a snapshot on every
commit (every 30 seconds) you'd be lucky to get below a 10x multiple ever.

The huge performance gain that came from not literally creating a
snapshot on every commit was that the backrefs didn't need to be updated
because the copied CoW pages were deleted in the same transaction that
created them.  If you're creating persistent copies on every commit, then
there's hundreds of ref updates on pages in every commit.  Maybe there's
some other way to do that (with a btrfs disk format change and maybe a
circular buffer delete list?), but the existing snapshot mechanisms are
much slower than disabled write caching.
