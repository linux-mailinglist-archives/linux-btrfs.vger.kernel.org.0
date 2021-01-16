Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0D2F8A38
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 02:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAPBFV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 15 Jan 2021 20:05:21 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33156 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbhAPBFU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 20:05:20 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1B671940570; Fri, 15 Jan 2021 20:04:38 -0500 (EST)
Date:   Fri, 15 Jan 2021 20:04:38 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Cedric.dewijs@eclipso.eu, Linux BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize
 the SSD?
Message-ID: <20210116010438.GG31381@hungrycats.org>
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <CAK-xaQZS+ANoD+QbPTHwL-ErapA-7PDZe_z=OOWq_axAyR1KfA@mail.gmail.com>
 <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de>
 <CAK-xaQbQPSS7=cH1qmb9S51CL34VRfyE_=eNwb-GhSL1b8Yz2g@mail.gmail.com>
 <20210109214032.GC31381@hungrycats.org>
 <CAK-xaQZ=ZNqkruDSjNdprDfj5nAh5TdCpT+sv0nB6LqCRu7dmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAK-xaQZ=ZNqkruDSjNdprDfj5nAh5TdCpT+sv0nB6LqCRu7dmQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 10, 2021 at 10:00:01AM +0100, Andrea Gelmini wrote:
> Il giorno sab 9 gen 2021 alle ore 22:40 Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> ha scritto:
> >
> > On Fri, Jan 08, 2021 at 08:29:45PM +0100, Andrea Gelmini wrote:
> > > Il giorno ven 8 gen 2021 alle ore 09:36 <Cedric.dewijs@eclipso.eu> ha scritto:
> > > > What happens when I poison one of the drives in the mdadm array using this command? Will all data come out OK?
> > > > dd if=/dev/urandom of=/dev/dev/sdb1 bs=1M count = 100?
> > You have used --assume-clean and didn't tell mdadm otherwise since,
> > so this test didn't provide any information.
> 
> I know mdadm, no need of your explanation.
> 
> "--assume-clean" is used on purpose because:
> a) the two devices are already identical;
> b) no need two sync something (even if they were random filled), that
> are going to be formatted and data filled, so - more or less - each
> block is rewritten.
> 
> > On real disks a mdadm integrity check at this point fail very hard since
> > the devices have never been synced (unless they are both blank devices
> > filled with the same formatting test pattern or zeros).
> 
> I disagree. My point is: who cares about blocks never touched by the filesystem?

If you don't do the sync, you don't get even mdadm's weak corruption
detection--it will present an overwhelming number of false positives.

Of course mdadm can only tell you the two devices are different--it
can't tell you which one (if any) is correct.

> > > root@glet:/mnt/sg10# dd if=/dev/urandom of=/dev/loop32 bs=1M count=100
> >
> > With --write-mostly, the above deterministically works, and
> >
> >         dd if=/dev/urandom of=/dev/loop31 bs=1M count=100
> >
> > deterministically damages or destroys the filesystem.
> 
> My friend, read the question, he asked about what happens if you
> poison the second device.

Strictly correct, but somewhere between unhelpful and misleading.

The motivation behind the question is clearly to compare mdadm and btrfs
capabilities wrt recovery from data poisoning.  He presented an example
of an experiment performed on btrfs demonstrating that capability.

He neglected to ask separate questions about poisoning both individual
drives, but you also neglected to point this omission out.

> Of course if you poison /dev/md0 or the main device what else can
> happen, in such situation?

What else can happen is that btrfs raid1 reconstructs the data on a
damaged device from the other non-damaged device, regardless of which
device is damaged.  btrfs can verify the contents of each device and
identify which copy (if any) is correct.  mdadm cannot.

> Thanks god you told us, because we are all so much stupid!

Well, the rule of thumb is "never use mdadm for any use case where you can
use btrfs instead," and answering yet another mdadm-vs-btrfs FAQ normally
wouldn't be interesting; however, this setup used mdadm --write-mostly
which is relatively unusual around here (and makes the posting appear
under a different set of search terms), so I wrote a short reply to
Cedric's question as it was not a question I had seen answered before.

Hours later, you presented an alternative analysis that contained the
results of an experiment that demonstrated mdadm success under specific
conditions arising from a very literal interpretation of the question.
I had to reread the mdadm kernel sources to remind myself how it could
work, because it's a corner case outcome that I've never observed or
even heard third-party reports of for mdadm in the wild.  That was a
fun puzzle to solve, so I wanted to write about it.

Your setup has significant data loss risks that you did not mention.
A user who was not very familiar with both btrfs and mdadm, but who
stumbled across this thread during a search of the archives, might not
understand the limited scope of your experimental setup and why it did
not detect or cause any of the expected data loss failures.  This user
might, upon reading your posting, incorrectly conclude that this setup
is a viable way to store data with btrfs self-repair capabilities intact.
Those were significant omissions, a second reason to write about them.

Initially I thought you accidentally omitted these details due to
inexperience or inattention, but as you say, you know mdadm.  If that's
true, your omissions were intentional.  That information is also
potentially not obvious for someone reading this thread in the archives,
so I am writing about it too.

> My point of view is: you can use mdadm to defend from real case
> scenario  (first hard drive die,
> the second slow one goes on, and you have all your data up to date,
> and if you are afraid of
> bit rotten data, you have btrfs checksum).
> Also, even if the second/slow hard drive is out-of-sync of seconds, it
> would like if unplugged while working.
> All cool feature of BTRFS (transaction, checksums, dup btree and so
> on) will recover filesystem and do the rest, isn't it?

No.  That was the point.  btrfs cannot fix mdadm if mdadm trashes both
copies of the data underneath.  The btrfs self-repair features only work
when btrfs has access to both mirror copies.  On top of mdadm, btrfs
can only help you identify the data you have already lost.  btrfs is
especially picky about its metadata--if even one bit of metadata is
unrecoverably lost, the filesystem can only be repaired by brute force
means (btrfs check --repair --init-extent-tree, or mkfs and start over).

This branch of the thread is a little over-focused on the bitrot case.
The somewhat more significant problem with this setup is that write
ordering rules are violated on sdb during resync with sda.  During resync
there may be no complete and intact copy of btrfs metadata on sdb, so
if sda fails at that time, the filesystem may be severely damaged or
unrecoverable, even if there is no bitrot at all.  Depending on write
workloads and disk speeds, the window of vulnerability may last for
minutes to hours.

That's a pretty common failure mode--a lot of drives don't die all
at once, especially at the low end of the market.  Instead, they have
reliability problems--the kind that will force a reboot and mdadm resync,
but not kick the device out of the array--just before they completely die.

If you are using mobile or desktop drives, the second most common 5-year
outcome from this setup will be filesystem loss.  The most common outcome
is that you don't have a disk failure on sda, so you don't need the second
disk at all.  Failures that mdadm can recover from are 3rd most likely,
followed by failures neither mdadm nor btrfs can recover from.

If you are using NAS or enterprise drives (and they're not relabled
desktop drives inside), then they are unlikely to throw anything at mdadm
that mdadm cannot handle; however, even the best drives break sometimes,
and this puts you in one of the other probability scenarios.

If you are using cheap SSDs then the probabilities flip because they
do not report errors that mdadm can detect, and they tend to trigger
more mdadm resyncs on average due to firmware issues and general
low reliability.  Partial data loss (that would have been recoverable
with btrfs raid1) is the most likely outcome, unrecoverable filesystem
failure is 2nd.  Keeping your data for 5 years moves down to the 3rd
most likely outcome.

Silent data corruption seems to be far more common on SSDs than HDDs, so
the risk of unrecoverable corruption is highest when mdadm --write-mostly
is used with the HDD as component disk #1 and the SSD as disk #0.

btrfs raid1 recovers from all of these cases except 2-drive same-sector
failures and host RAM failure.

Also, your stated use case is slightly different from Cedic's:

> You can use mdadm to do this (I'm using this feature since years in
> setup where I have to fallback on USB disks for any reason).

Here, you are mirroring up a relatively reliable disk onto one or more
removable USB devices.  Depending on the details, this setup can have
a different failure profile than the SSD/HDD use case.  If you rotate
multiple USB devices so that you always have one offline intact mirror of
the filesystem, then if there is a failure during resync and the online
USB disk has a destroyed filesystem, the offline disk will still be
intact and you can still use it to recover, but it will have older data.
In the SSD/HDD use case, there is only one mirror pair, so there is no
isolated copy that could survive a failure during resync.

The corruption propagation between drives is different too--if you can
run a btrfs scrub, and detect corruption on the primary drive in time,
you can retrieve the missing data from the offline mirror.  With only
two online drives, it's a challenge to access the intact mirror (you
have to ensure mdadm never resyncs, and use btrfs restore directly on
the mirror device).

> Thinking about "what if I trick my system here and there" is
> absolutely fun, but no real use case, for me.

It is a real use case for other people.  Disks do silently corrupt data
(especially low end SSDs), so it's reasonable to expect a modern raid1
implementation to be able to recover from damage to either drive, and
reasonable to test that capability by intentionally wiping one of them.
Just remember to test wiping the other one too.

> What if I expose BTRFS devices to cosmic rays and everything is wiped out?
> 
> (I know, my only hero Qu is already preparing a patch - as usual -
> while others starts to write poems...)
> 
> Don't take it personally and smile,
> Gelma
