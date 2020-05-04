Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AC1C3051
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 02:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgEDAFV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 3 May 2020 20:05:21 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47142 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgEDAFU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 May 2020 20:05:20 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E23986A34BA; Sun,  3 May 2020 20:04:59 -0400 (EDT)
Date:   Sun, 3 May 2020 20:04:59 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Rollo ro <rollodroid@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: raid56 write hole
Message-ID: <20200504000456.GP10769@hungrycats.org>
References: <CAAhjAp1zrjrizrswo3BF1-cTXArpZ5XFUPbd-OR_Nu1N05pdSQ@mail.gmail.com>
 <20200501023029.GD10769@hungrycats.org>
 <CAAhjAp0xitJN0S7T9DPEO84ELAYyWi1-k7ZRZSd1vddT4ozbTA@mail.gmail.com>
 <20200502055654.GJ10769@hungrycats.org>
 <CAAhjAp1mg-KF+YY=y_t-KEYHp-0uST84vS1z1=mEG858DzWX4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAAhjAp1mg-KF+YY=y_t-KEYHp-0uST84vS1z1=mEG858DzWX4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 03, 2020 at 02:40:05AM +0200, Rollo ro wrote:
> Am Sa., 2. Mai 2020 um 07:56 Uhr schrieb Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org>:
> >
> > On Fri, May 01, 2020 at 03:57:20PM +0200, Rollo ro wrote:
> > > Am Fr., 1. Mai 2020 um 04:30 Uhr schrieb Zygo Blaxell
> > > <ce3g8jdj@umail.furryterror.org>:
> 
> 
> >
> > None of the superblocks are updated before all of the new trees are
> > flushed.  So either the old or new state is acceptable.  I believe the
> > current btrfs implementation will try to choose the newer one.
> >
> 
> Yes I understood that first the trees are finished and only after that
> the superblocks updated to point to the new tree version. But now this
> superblockupdate write command is sent to both drives. Drive 1 writes
> it correctly but drive 2 has problems and keeps trying for 7 seconds
> (depending on drive model and settings) before it will report an
> error. Now a power outage hits in this 7 seconds period. On the next
> boot we have drive 1 with the new version and drive 2 with the old
> version. Drive 2 could be updated with information from drive 1, but
> we lost redundancy then. Hence, I'd let both drives use the old
> version. It seems acceptable for me to lose the very last writes.
> 
> > If all your drives lie about completing flushes, unrecoverable data loss
> > may occur.  If only one of your drives lies, btrfs will repair (*) any lost
> > data on the bad drive by copying it from the good drive.
> >
> > (*) except nodatasum data and data with a csum collision between good and
> > bad data.
> >
> 
> Is this a thing in real drives? And if yes, how can one find out which
> drive models are affected?

Yes, it's a real thing.  We found some buggy WD Black, Green, and Red
models from 2014 the hard way.  For all we know they're still buggy--
we've stopped buying them, so we don't have any further test data.

Some drives hide their failures well--the WD Black is completely fine,
passing all our power-cycle tests, then it gets one UNC sector and
starts failing the write caching test very very hard.  We can't really
test for that case, so we just rely on btrfs to detect the failure
after it happens, and treat the event as a full-disk loss.  Then we
turn off write caching on every drive with that firmware in our fleet
and we don't have further problems in the drive service lifetime.

> > If a superblock write fails, it either leaves old data (with an old transid)
> > or it fails a csum check (and the whole device is likely ignored).  Picking
> > the highest transid with a valid superblock csum would suffice.
> 
> Yes, hence I think it's not a good idea to write it all the time. I
> noticed that there are other attributes that need to be updated
> frequently, but think that should be in what I called candidates. The
> superblock is ideally written only once during filesystem creation and
> for repairing if needed, and contains two (or more) addresses to go
> on. The roots at these two (or more) addresses are then written
> alternately.

I haven't seen compelling evidence that writing the same block over
and over is particularly bad (except on maybe cheap SD/MMC media, but
they have such tiny endurance ratings that any writes will kill them,
it's hard to find correlations).

It would be nice if btrfs would automatically _read_ all the superblocks.
It does write all of them.  The asymmetry there is weird.

> > If the superblocks have the same generation but different addresses that's
> > a bug in btrfs, or both halves of split-brain raid1 were reunited after
> > they were mounted separately.  btrfs doesn't handle the latter case
> > at all well--it destroys the filesystem.
> 
> Good to know. At least that can't happen by itself, because it won't
> mount without the degraded option.
> 
> >  mdadm has a solution there,
> > they put a timestamp (a random nonce will do) on each drive so that a
> > reunited split-brain raid1 won't come online with both drives.
> >
> 
> >
> > As far as I know, no.  It's typically used in cases where the latest root
> > passes sanity checks but turns out to be bad later on.
> >
> 
> >
> > Writes can continue on all drives as long as 1) superblocks always
> > refer to fully complete trees, 2) superblocks are updated in lockstep,
> > at most one transid apart, and 3) when userspace explicitly requests
> > synchronization (e.g. fsync), the call blocks until the associated trees
> > and superblocks are completely flushed on all drives.
> >
> > Note that this relies on the CoW update mechanism, so there is no
> > guarantee of data integrity with nodatacow files (they do have write
> > hole problems at every raid level).
> >
> > In the kernel it's a bit less flexible--there's only one active
> > transaction per filesystem, and it must fully complete before a new
> > transaction can begin.  This results in latency spikes around the
> > commit operation.
> >
> 
> >
> > The write ordering does cover crash and power outage.  What else could it
> > be for?  Mounting with -o nobarrier turns off the write ordering, and
> > makes the filesystem unlikely to survive a power failure.
> 
> That's clear. If we want the sequence:
> Write some data on disk --> Write the data's address into superblock
> a drive could change the sequence to save time and then there is a
> period during that the data is missing. To prevent that, we do:
> Write some data on disk --> barrier --> Write the data's address into superblock
> 
> But it doesn't help if we have two drives and one finishes the
> sequence, but the other drive not, because of power outage.

So...there are multiple flavors of "barrier" and they're all called
"barrier"...

The kernel currently waits for every drive to finish writing trees, then
sends commands to update all the superblocks, waits for all of those to
finish, then goes back to writing trees.  This uses two "barrier" phases:
the first starts writing cached data on all disks, the second waits for
the write to finish on all disks (or the closest equivalent to that
which is supported by the drive's firmware).  It's very synchronous.
All filesystem modifications pause while that happens; however, it's
one of only two cases where btrfs needs to use any kind of barrier
(the other is fsync() on nodatacow files, which as before are subject
to write hole issues).

In theory each disk can have multiple transactions in progress in a
pipeline arrangement, e.g. it can start writing tree #2 immediately
after issuing the superblock update write for tree #1, without waiting
for other drives, as long as it never updates the superblock for tree
#2 until all copies of tree #2 are up to date.  In practice there are
a lot of issues to be worked out before we get there, e.g. tree #1
is supposed to free disk space that can be used for tree #2, so to do
pipelining of commits, those free spaces have to be deferred to tree #3.
The kernel doesn't support that yet (or maybe ever).  The same mechanism,
if implemented, would allow backup superblock root node pointers to be
useful to recover older trees in the filesystem.

> > During kernel and hardware qualification tests we hook up a prospective
> > new server build to a software-controlled power switch and give it 50
> > randomly-spaced power failures a week.  It has to run btrfs stress
> > tests for a month to pass.
> 
> That will in most cases miss a problem that the system is vulnerable
> to for 10ms every 10s for example. Good test, though.

Real drives with firmware bugs are vulnerable for far longer than
10ms per 10s.  We give them 200 tries to demonstrate their bugginess,
but most of the failing drives demonstrate their failure in under 10.
Drives typically have lifetime power cycle counts in the low teens in a
data center (and usually only get powered down after something has failed,
bringing writes from the host to a stop).  200 power cycles represents
decades of data center usage, or 5-10 years in a site office on a UPS
depending on weather.

A probability of 0.1% per power cycle is low enough that we expect
total drive failure to happen much more often.

We don't have a good test for firmware that drops the write cache on UNC
sector (maybe _carefully_ tap the drive with a hammer?).  UNC sectors
appear at an annual rate around 1-5% depending on model, far higher than
other failure rates.

For single-disk systems where we don't get to pick the drive model
(like cloud nodes), we can do the risk analysis to decide whether we
need performance and can tolerate losing 5% of the nodes every year,
or disable the write cache and lose 0.5% of the nodes every year.

For SOHO light-duty file server use cases where you can't afford to
break a specimen machine in a test lab and you don't have many nodes to
replicate over, disabling the write cache on all drives is a cheap and
safe way to avoid firmware bugs.

> > Maybe it does, but upstream btrfs doesn't use it.
> >
> >
> > If you have enough drives in your topology, you can join the devices in
> > the same failure domain together as mdadm or lvm JBOD devices and then
> > btrfs raid1 the JBOD arrays.
> 
> Good idea!
> 
> > > So for now, I'll be limited to 4 drives
> > > and if I need more, I'll probalby get an additional PCIe SATA card.
> >
> > Usually I trace that kind of problem back to the power supply, not
> > the SATA card.  Sure, there are some terrible SATA controller chips out
> > there, but even good power supplies will turn bad after just a few years.
> > We replace power supplies on a maintenance schedule whether they are
> > failing or not.
> >
> > Sometimes when spinning drives fail, they pull down hard on power rails
> > or even feed kinetic energy from the motors back into the power supply.
> > This can disrupt operation and even break other devices.  This gets worse
> > if the power supply is aging and can't fight the big current flows.
> >
> 
> Yes that's possible. I still suspect the SATA port more, as it was
> always on one controller.
> 
> 
> >
> > ...and you let this continue?  raid1 is 2-device mirroring.  If you
> > have simultaneous 2-device failures the filesystem will die.  It's right
> > there in the spec.
> >
> 
> It's not real usage yet. I'm just evaluating. I know that it can only
> cope with one drive failure. Did'n expect that the other drive also
> will be affected.

Now you know, and can adjust the design (e.g. rearrange power cables to
avoid overloading a single wire set, upgrade the power supply, add
extra SATA ports on PCIe cards, use a mainboard that has 6 working
SATA ports...).

Even after all the risks are mitigated, there's always a (smaller)
probability of something going wrong that takes out the whole array.

> > One failure is fine.
> 
> Not with this particular failure I was refering to, that "auto-fails"
> another drive.

That's not one failure, is it?  ;)

Correlated failures are well known in RAID system design, and a familiar
nightmare to RAID system designers.

> >  You can mitigate that risk by building arrays out
> > of diverse vendor models, and even ages if possible (we also rotate
> > disks out of live arrays on a schedule, whether they're failing or
> > not).
> 
> I learned that when I was like 16 years old. Saved all my money to buy
> 4 IBM DTLA. And then they failed faster than I could replace and the
> replaced drives failed again.

My formative experience was 18 Maxtor 160GB drives.  13 of the original
set failed in 5 months, and I lost count of how many RMA replacments
failed.  Several were DOA.  Backups were used in anger.

> > Two or more failures are always possible.  That's where backups become
> > useful.
> 
> I'd really like to use raid 6, though, if it only had not this problem.
> 
> >
> 
> >
> > This is maybe true of drives that are multiple years past their warranty
> > end date, where almost any activity--even carefully moving the server
> > across the room--will physically break the drive.  It's certainly not true
> > of drives that are in-warranty (*)--we run scrubs biweekly on those for
> > years, in between heavy read-write IO loads that sometimes run for months.
> >
> > People who say things are often surprised when they don't run a scrub
> > for a year and suddenly discover all the errors that have been slowly
> > accumulating on their drives for months, and they think that it's the
> > scrub _causing_ the problem, instead of merely _reporting_ problems that
> > occurred months earlier.
> 
> Well, that function is one of the main reasons to use zfs/btrfs. I'm
> wondering why people use it and don't scrub. And then scrub but don't
> know why.
> 
> >
> > Run a scrub so you'll know how your drives behave under load.  Run a
> > scrub every month (every day if you can, though that's definitely more
> > than necessary) so you'll know if your drives' behavior is changing as
> > they age, and also whether your host system in general is going to be
> > able to survive any kind of RAID failure.  If the system can't cope with
> > a scrub when disks are healthy, it's definitely not going to be able to
> > recover from disk failures.  Drives that are going to break in scrub are
> > going to break during RAID recovery too.  You want to discover those
> > problems as soon as possible so you can replace the faulty components
> > before any data is lost.
> 
> True!
> 
> >
> > (*) except Seagate Barracudas manufactured between 2011 and 2014.
> >
> >
> > If this occurs, and is reported to btrfs, then btrfs aborts all future
> > writes as well, as a critical disk update failed.  If it occurs without
> > reporting then it's just another case of silent data corruption for btrfs
> > to clean up with self-repair later on.  If the one sector on your disk
> > that is unreadable after a crash is the one 64K offset from the start
> > of your btrfs, but the rest of the disk is still usable, you've hit the
> > one-in-a-billion target (a 4 TB drive has a billion 4K sectors on it).
> >
> > There are lots of other ways disks can fail, but they mostly reduce to
> > integrity failures that btrfs handles easily with raid1 and at most one
> > disk failure.
> >
> 
> >
> > Yes, btrfs is very conservative there.  btrfs requires explicitly
> > authorizing a degraded array read-write mount too.
> >
