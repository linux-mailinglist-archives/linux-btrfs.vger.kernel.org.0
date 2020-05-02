Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058FD1C2367
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 07:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEBF47 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 01:56:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42034 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgEBF46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 01:56:58 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 47EA369FB45; Sat,  2 May 2020 01:56:55 -0400 (EDT)
Date:   Sat, 2 May 2020 01:56:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Rollo ro <rollodroid@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: raid56 write hole
Message-ID: <20200502055654.GJ10769@hungrycats.org>
References: <CAAhjAp1zrjrizrswo3BF1-cTXArpZ5XFUPbd-OR_Nu1N05pdSQ@mail.gmail.com>
 <20200501023029.GD10769@hungrycats.org>
 <CAAhjAp0xitJN0S7T9DPEO84ELAYyWi1-k7ZRZSd1vddT4ozbTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhjAp0xitJN0S7T9DPEO84ELAYyWi1-k7ZRZSd1vddT4ozbTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 03:57:20PM +0200, Rollo ro wrote:
> Am Fr., 1. Mai 2020 um 04:30 Uhr schrieb Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org>:
> >
> > On Thu, Apr 30, 2020 at 07:00:43PM +0200, Rollo ro wrote:
> > > Hi, I read about the write hole and want to share my thoughts. I'm not
> > > sure if I got it in full depth but as far as I understand, the issue
> > > is about superblocks on disks, the superblocks containing addresses of
> > > tree roots and if the trees are changed using copy on write, we have a
> > > new root and it's address needs to be written into the superblock.
> > > That leads to inconsistent data if one address is updated but another
> > > one is not. Is this about right?
> >
> > Nope.  See Wikipedia, or google for "write hole".  When people say
> > "write hole", especially in a btrfs context, they are almost always
> > talking about raid5.
> >
> > btrfs's raid1 write hole is handled by btrfs cow update write ordering
> > (assuming the drives have working write ordering, and that a write to
> > any individual sector on a disk does not change the content of any other
> > sector on that or any other disk).  The update ordering assumes the
> > drive can reorder writes between barriers, so it trivially handles the
> > raid1 cases.  Any updates that fail to land on one disk or the other are
> > not part of the filesystem after a crash, because the transaction that
> > contains them did not complete.  Superblocks are updated on the opposite
> > side of the barrier, so we know all disks have the new filesystem tree
> > on disk before any superblock points to it (and of course the old tree
> > is still there, so if the superblock is not updated that's OK too).
> 
> Thanks for your detailled reply! I understood the COW thing, where
> both the old and new state is valid and it only takes to switch over
> to the new root. It's all about this "switch over". Even with correct
> working barriers, it's possible than one drive finished and another
> drive could not finish because of a crash or whatever, right? In that
> case, if we assume raid 1, will BTRFS use the old state on all drives?

None of the superblocks are updated before all of the new trees are
flushed.  So either the old or new state is acceptable.  I believe the
current btrfs implementation will try to choose the newer one.

If all your drives lie about completing flushes, unrecoverable data loss
may occur.  If only one of your drives lies, btrfs will repair (*) any lost
data on the bad drive by copying it from the good drive.

(*) except nodatasum data and data with a csum collision between good and
bad data.

> > The write hole problem on btrfs arises because updates to raid5 parity
> > blocks use read-modify-write, i.e. they do an update in place with no
> > journal, while the CoW layer relies on the raid profile layer to never
> > do that.  This can be fixed either way, i.e. make the raid5 layer do
> > stripe update journalling, or make the CoW layer not modify existing
> > raid5 stripes.  Both options have significant IO costs that are paid at
> > different times (much later in the second case, as something like garbage
> > collection has to run periodically).  mdadm's raid5 implementation picked
> > the first option.  ZFS picked the second option (in the sense that their
> > RAIDZ stripes are immutable and always exactly the width of any data
> > they write, so they never modify an existing stripe).  btrfs has taken
> > 7 years to not implement either solution yet.
> >
> > ZFS pushed the parity into the CoW layer, so it's handled in a manner
> > similar to the way btrfs handles filesystem compression.  This could be
> > done on btrfs too, but the result would be an entirely new RAID scheme
> > that would be used instead of the current btrfs raid5/6 implementation
> > (the latter would be deprecated).  Doing it this way could work in
> > parallel with the existing raid profiles, so it could be used to implement
> > something that looks like raid5+1 and other layered redundancy schemes.
> >
> > There's currently a bug which occurs after data has been corrupted by
> > any cause, including write hole:  btrfs updates parity without checking
> > the csums of all the other data blocks in the stripe first, so btrfs
> > propagates data corruption to parity blocks, and the parity blocks cannot
> > be used to reconstruct the damaged data later.  This is a distinct problem
> > from the write hole, but it means that given identical disk behavior,
> > btrfs's raid1* implementations would recover from all detectable errors
> > while btrfs's raid5/6 implementation will fail to correct some errors.
> 
> Yes I read about that. It's neccessary to do a second scrub for now.

A second scrub reduces the risk, but a correct implementation would not have
the risk at all.

> > > (I'm not sure whether we are talking
> > > here about a discrepancy between two root adresses in one superblock,
> > > or between two superblocks on different disks or possibly both)
> > >
> > > In my opinion, it's mandatory to have a consistent filesystem at _any_
> > > point in time, so it can't be relied on flush to write all new
> > > addresses!
> > >
> > > I propose that the superblock should not contain the one single root
> > > address for each tree that is hopefully correct, but it should contain
> > > an array of addresses of tree root _candidates_.
> >
> > I invite you to look at the existing btrfs on-disk structures.
> 
> I looked again and see that there is a backup. But if a superblock
> write fails, also the backup could be broken. And if the backup points
> to another address it's not clear which one is correct.

If a superblock write fails, it either leaves old data (with an old transid)
or it fails a csum check (and the whole device is likely ignored).  Picking
the highest transid with a valid superblock csum would suffice.

If the superblocks have the same generation but different addresses that's
a bug in btrfs, or both halves of split-brain raid1 were reunited after
they were mounted separately.  btrfs doesn't handle the latter case
at all well--it destroys the filesystem.  mdadm has a solution there,
they put a timestamp (a random nonce will do) on each drive so that a
reunited split-brain raid1 won't come online with both drives.

> > > Also, the addresses
> > > in the superblocks are written on filesystem creation, but not in
> > > usual operation anymore. In usual operation, when we want to switch to
> > > a new tree version, only _one_ of the root candidates is written with
> > > new content, so there will be the latest root but also some older
> > > roots. Now the point is, if there is a power outage or crash during
> > > flush, we have all information needed to roll back to the last
> > > consistent version.
> >
> > There are already multiple superblocks on btrfs, and they each hold
> > several candidates.  The "usebackuproot" mount option can try to use one.
> 
> This is much like I intended, but I'd described an automatic
> negotiation of which one to use. Is "usebackuproot" able to use a
> combination of a standard and backup root?

As far as I know, no.  It's typically used in cases where the latest root
passes sanity checks but turns out to be bad later on.

> > > We just need to find out which root candidate to use.
> >
> > Don't even need to do that--during a transaction commit, either root is
> > valid (nothing's committed to disk until btrfs returns to userspace).
> 
> Does that mean that further writes are paused until the transaction is
> finished on a per-drive basis, or per-array? 

Writes can continue on all drives as long as 1) superblocks always
refer to fully complete trees, 2) superblocks are updated in lockstep,
at most one transid apart, and 3) when userspace explicitly requests
synchronization (e.g. fsync), the call blocks until the associated trees
and superblocks are completely flushed on all drives.

Note that this relies on the CoW update mechanism, so there is no
guarantee of data integrity with nodatacow files (they do have write
hole problems at every raid level).

In the kernel it's a bit less flexible--there's only one active
transaction per filesystem, and it must fully complete before a new
transaction can begin.  This results in latency spikes around the
commit operation.

> Also, as I understand,
> this doesn't cover crash or power outage,right?

The write ordering does cover crash and power outage.  What else could it
be for?  Mounting with -o nobarrier turns off the write ordering, and
makes the filesystem unlikely to survive a power failure.

During kernel and hardware qualification tests we hook up a prospective
new server build to a software-controlled power switch and give it 50
randomly-spaced power failures a week.  It has to run btrfs stress
tests for a month to pass.

> > > (This is why I
> > > call them candidates) To achieve that, the root candidates have an
> > > additional attribute that's something like a version counter and we
> > > also have a version counter variable in RAM. On a transition we
> > > overwrite the oldest root candidate for each tree with all needed
> > > information, it's counter with our current counter variable, and a
> > > checksum. The counter variable is incremented after that. At some
> > > point it will overflow, hence we need to consider that when we search
> > > the latest one. Let's say we use 8 candidates, then the superblock
> > > will contain something like:
> > >
> > > LogicalAdress_t AddressRootCandidatesMetaData[8]
> > > LogicalAdress_t AddressRootCandidatesData[8]
> > >
> > > (just as an example)
> > >
> > > While mounting, we read all '8 x number of trees x disks' root
> > > candidates, lookup their version counters and check ZFS checksums.
> > > We have a struct like
> > >
> > > typedef struct
> > > {
> > >     uint8_t Version;
> > >     CheckResult_te CeckResult; /* enum INVALID = 0, VALID = 1 */
> > > } VersionWithCheckResult_t
> > >
> > > and build an array with that:
> > >
> > > enum {ARRAY_SIZE = 8};
> > > VersionWithCheckResult_t VersionWithCheckResult[ARRAY_SIZE];
> > >
> > > and write it in a loop. For example we get:
> > >
> > > {3, VALID}, {4, VALID}, {253, VALID}, {254, VALID}, {255, VALID}, {0,
> > > VALID}, {1, VALID}, {2, VALID}
> > > (-> Second entry is the most recent valid one)
> > >
> > > We'd like to get this from all disks for all trees, but there was a
> > > crash so some disks may have not written the new root candidate at
> > > all:
> > >
> > > {3, VALID}, {252, VALID}, {253, VALID}, {254, VALID}, {255, VALID},
> > > {0, VALID}, {1, VALID}, {2, VALID}
> > > (-> First entry is the most recent valid one, as the second entry has
> > > not been updated)
> > >
> > > or even left a corrupted one, which we will recognize by the checksum:
> > > (-> First entry is the most recent valid one, as the second entry has
> > > been corrupted)
> > >
> > > {3, VALID}, {123, INVALID}, {253, VALID}, {254, VALID}, {255, VALID},
> > > {0, VALID}, {1, VALID}, {2, VALID}
> > >
> > > Then we walk through that array, first searching the first valid
> > > entry, and then look if there are more recent, valid entries, like:
> > >
> > > uint8_t IndexOfMostRecentValidEntry = 0xFF;
> > > uint8_t i = 0;
> > > while ((i < ARRAY_SIZE) && (IndexOfMostRecentValidEntry == 0xFF))
> > > {
> > >     if (VersionWithCheckResult[i].CheckResult == VALID)
> > >     {
> > >         IndexOfMostRecentValidEntry = i;
> > >     }
> > > }
> > >
> > > for (i = 0, i < ARRAY_SIZE, i++)
> > > {
> > >     uint8_t IndexNext = CalcIndexNext(IndexOfMostRecentValidEntry); /*
> > > Function calculates next index with respect to wrap around */
> > >     uint8_t MoreRecentExpectedVersion =
> > > VersionWithCheckResult[IndexOfMostRecentValidEntry].Version + 1u; /*
> > > Overflows from 0xFF to 0 just like on-disk version numbers */
> > >     if ((VersionWithCheckResult[IndexNext].Version ==
> > > MoreRecentExpectedVersion) &&
> > > (VersionWithCheckResult[IndexNext].CheckResult == VALID))
> > >     {
> > >         IndexOfMostRecentValidEntry = IndexNext;
> > >     }
> > > }
> > >
> > > Then we build another array that will be aligned to the entry we found:
> > >
> > > VersionWithCheckResultSorted[ARRAY_SIZE] = {0}; /* All elements inited
> > > as 0 (INVALID) */
> > > uint8_t Index = IndexOfMostRecentValidEntry;
> > > for (i = 0, i < ARRAY_SIZE, i++)
> > > {
> > >     VersionWithCheckResultSorted[i] = VersionWithCheckResult[Index];
> > >     Index = CalcIndexPrevious(Index); /* Function calculates previous
> > > index with respect to wrap around */;
> > > }
> > >
> > > With the 3 example datasets from above, we get:
> > >
> > > {4, VALID}, {3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255,
> > > VALID}, {254, VALID}, {253, VALID}
> > > {3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255, VALID}, {254,
> > > VALID}, {253, VALID}, {252, VALID},
> > > {3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255, VALID}, {254,
> > > VALID}, {253, VALID}, {123, INVALID},
> > >
> > > Now the versions are prioritized from left to right. It's easy to
> > > figure out that the latest version we can use is 3. We just fall back
> > > to the latest version for that we found a valid root candidate for
> > > every tree. In this example, it's index = 0 in the superblock array.
> > > So we use that to mount and set the counter variable to 1 for the next
> > > writes.
> > >
> > > As a consequence, there is no write hole, because we always fall back
> > > to the latest state that is consistently available and discard the
> > > last write if it has not been finished correctly for all trees.
> > >
> > > notes:
> > > - It's required that also the parity data is organized as COW trees. I
> > > don't know if it's done that way now.
> >
> > It is not, which is the reason why btrfs has a raid5 write hole.
> 
> I guess it should, to have the consitency. But there are more options
> that you explained above.
> 
> > The on-disk layout is identical to mdadm raid5/6 with no journal or PPL,
> > so btrfs will fail in most of the same ways if you run single-device
> > btrfs on top of a mdadm raid5.
> 
> That's interesting!! Because as far as I know, some NAS like Synology
> use exactly that to workaround the write hole. So this doesn't work?

Maybe it does, but upstream btrfs doesn't use it.

> > dup metadata on mdadm-raid5 might give
> > you a second roll of the dice to keep your data on every crash and power
> > failure, but it's categorically inferior to btrfs raid1 metadata which
> > doesn't roll dice in the first place.
> 
> Raid 1 rolls some other dice, though. This is more a hardware related
> issue. I observed that a known-bad drive from my old NAS takes down
> the other drive that is connected to the same SATA controller. I did
> excessive testing with the good drive alone, using badblocks, watched
> SMART parameters, watched kernel messages. Whatever I do with the
> drive alone, it just works without any problems. So I'm sure the drive
> is good. With both the good and bad drive connected, I get problems on
> both drives, like reduced SATA speed, fall back to USMA133, link down,
> IO errors etc, which has led to data loss multiple times until now.
> There is effectively no redundany in that case. As far as I figured
> yet, it will work best with raid 1 and limit to one drive per SATA
> controller. An option that takes into account the SATA controllers
> would be great, so that raid 1 does not save the data on two drives
> that are on one controller. 

If you have enough drives in your topology, you can join the devices in
the same failure domain together as mdadm or lvm JBOD devices and then
btrfs raid1 the JBOD arrays.

> So for now, I'll be limited to 4 drives
> and if I need more, I'll probalby get an additional PCIe SATA card.

Usually I trace that kind of problem back to the power supply, not
the SATA card.  Sure, there are some terrible SATA controller chips out
there, but even good power supplies will turn bad after just a few years.
We replace power supplies on a maintenance schedule whether they are
failing or not.

Sometimes when spinning drives fail, they pull down hard on power rails
or even feed kinetic energy from the motors back into the power supply.
This can disrupt operation and even break other devices.  This gets worse
if the power supply is aging and can't fight the big current flows.

> > > - For now I assumed that a root candidate is properly written or not.
> > > One could think of skipping one position and go to the next canditate
> > > in case of a recognized write error, but this is not covered in this
> > > example. Hence, if there is an invalid entry, the lookup loop does not
> > > look for further valid entries.
> >
> > btrfs will try other disks, but the kernel will only try one superblock
> > per disk.
> >
> > There is a utility to recover other superblocks so you can recover from
> > the one-in-a-billion chance that the only sector that gets corrupted on
> > the last write before a system crash or power failure on an otherwise
> > working disk happens to be the one that holds the primary superblock.
> 
> I'd like to have things like that considered as standard use cases
> that are just handled correctly, which is possible in theory. I think
> it's wrong to consider this an one-in-billion chance. As my tests
> show, things can go wrong easily and often with broken hardware. Also,
> a backup does not really help. Of cause I better have a backup when my
> btrfs NAS fails, but the point is, that if I have two copies and one
> has a chance of 99,99999999% to survive for a specific time, and the
> other one only 5%, it doesn't improve the overall chance
> significantly. Hence, every storage needs to be robust, otherwise you
> can just discard it from the equation. With my current setup, btrfs
> shows to be highly unreliable, I think this is much caused by the fact
> that I get frequent 2 disk errors 

...and you let this continue?  raid1 is 2-device mirroring.  If you
have simultaneous 2-device failures the filesystem will die.  It's right
there in the spec.

> and my distro doesn't have the
> latest btrfs version so I can't use r1c3 for metadata. Sure I'm using
> old drives, but if I come up with the real build and good drives, one
> of them will possibly have the same error some day. 

One failure is fine.  You can mitigate that risk by building arrays out
of diverse vendor models, and even ages if possible (we also rotate
disks out of live arrays on a schedule, whether they're failing or
not).

Two or more failures are always possible.  That's where backups become
useful.

> I'm glad that I
> recognized to better not use both channels of a SATA controller.
> People say that an array rebuild puts stress on the drives which can
> lead to another drive failure. 

This is maybe true of drives that are multiple years past their warranty
end date, where almost any activity--even carefully moving the server
across the room--will physically break the drive.  It's certainly not true
of drives that are in-warranty (*)--we run scrubs biweekly on those for
years, in between heavy read-write IO loads that sometimes run for months.

People who say things are often surprised when they don't run a scrub
for a year and suddenly discover all the errors that have been slowly
accumulating on their drives for months, and they think that it's the
scrub _causing_ the problem, instead of merely _reporting_ problems that
occurred months earlier.

Run a scrub so you'll know how your drives behave under load.  Run a
scrub every month (every day if you can, though that's definitely more
than necessary) so you'll know if your drives' behavior is changing as
they age, and also whether your host system in general is going to be
able to survive any kind of RAID failure.  If the system can't cope with
a scrub when disks are healthy, it's definitely not going to be able to
recover from disk failures.  Drives that are going to break in scrub are
going to break during RAID recovery too.  You want to discover those
problems as soon as possible so you can replace the faulty components
before any data is lost.

(*) except Seagate Barracudas manufactured between 2011 and 2014.

> Maybe much of this is caused by a SATA
> controller problem like I described. I didn't know that utility, so I
> can't tell whether I would have been able to recover with that. I
> already wiped everything and started over.
> 
> >
> > > - All data that all 8 root canditates point to need to be kept because
> > > we don't know which one will be used on the next mount. The data can
> > > be discarded after a root candidate has been overwritten.
> > > - ARRAY_SIZE basically could be 2. I just thought we could have some more
> >
> > You only need two candidates if you have working write ordering.  If you
> > don't have working write ordering, or you want ARRAY_SIZE > 2, you have
> > to teach the transaction logic to keep more than two trees intact at
> > any time.  People have attempted this, it's not trivial.  Right now
> 
> Yes, using 8 was just an example.
> 
> > there are 3 root backups in each superblock and there's no guarantee that
> > 2 of them still point to an intact tree.
> 
> Of cause there is never a 100% guarantee, but I think it should be
> expected that a write can be aborted any time and still leave a valid,
> mountable filesystem by design. 

If this occurs, and is reported to btrfs, then btrfs aborts all future
writes as well, as a critical disk update failed.  If it occurs without
reporting then it's just another case of silent data corruption for btrfs
to clean up with self-repair later on.  If the one sector on your disk
that is unreadable after a crash is the one 64K offset from the start
of your btrfs, but the rest of the disk is still usable, you've hit the
one-in-a-billion target (a 4 TB drive has a billion 4K sectors on it).

There are lots of other ways disks can fail, but they mostly reduce to
integrity failures that btrfs handles easily with raid1 and at most one
disk failure.

> A huge part of that is done using the
> COW tree concept, but not at the top level of the tree, as it seems,
> as it requires manual action to repair.

Yes, btrfs is very conservative there.  btrfs requires explicitly
authorizing a degraded array read-write mount too.

> > > What do you think?  It's one of the more conservative desii
