Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE3500C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 06:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFXE3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 00:29:33 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45874 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726812AbfFXE3d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 00:29:33 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id ECE2A35CD5A; Mon, 24 Jun 2019 00:29:29 -0400 (EDT)
Date:   Mon, 24 Jun 2019 00:29:29 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery
 not possible)
Message-ID: <20190624042926.GA11820@hungrycats.org>
References: <20190623204523.GC11831@hungrycats.org>
 <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 08:46:06AM +0800, Qu Wenruo wrote:
> On 2019/6/24 =E4=B8=8A=E5=8D=884:45, Zygo Blaxell wrote:
> > On Thu, Jun 20, 2019 at 01:00:50PM +0800, Qu Wenruo wrote:
> >> On 2019/6/20 =E4=B8=8A=E5=8D=887:45, Zygo Blaxell wrote:
[...]
> So the worst scenario really happens in real world, badly implemented
> flush/fua from firmware.
> Btrfs has no way to fix such low level problem.
>=20
> BTW, do you have any corruption using the bad drivers (with write cache)
> with traditional journal based fs like XFS/EXT4?

Those filesystems don't make full-filesystem data integrity guarantees
like btrfs does, and there's no ext4 equivalent of dup metadata for
self-repair (even metadata csums in ext4 are a recent invention).
Ops didn't record failure events when e2fsck quietly repairs unexpected
filesystem inconsistencies.  On ext3, maybe data corruption happens
because of drive firmware bugs, or maybe the application just didn't use
fsync properly.  Maybe two disks in md-RAID1 have different contents
because they had slightly different IO timings.  Who knows?  There's no
way to tell from passive ops failure monitoring.

On btrfs with flushoncommit, every data anomaly (e.g. backups not
matching origin hosts, obviously corrupted files, scrub failures, etc)
is a distinct failure event.  Differences between disk contents in RAID1
arrays are failure events.  We can put disks with two different firmware
versions in a RAID1 pair, and btrfs will tell us if they disagree, use
the correct one to fix the broken one, or tell us they're both wrong
and it's time to warm up the backups.

In 2013 I had some big RAID10 arrays of WD Green 2TB disks using ext3/4
and mdadm, and there were a *lot* of data corruption events.  So many
events that we didn't have the capacity to investigate them before new
ones came in.  File restore requests for corrupted data were piling up
faster than they could be processed, and we had no systematic way to tell
whether the origin or backup file was correct when they were different.
Those problems eventually expedited our migration to btrfs, because btrfs
let us do deeper and more uniform data collection to see where all the
corruption was coming from.  While changing filesystems, we moved all
the data onto new disks that happened to not have firmware bugs, and all
the corruption abruptly disappeared (well, except for data corrupted by
bugs in btrfs itself, but now those are fixed too).  We didn't know
what was happening until years later when the smaller/cheaper systems
had enough failures to make noticeable patterns.

I would not be surprised if we were having firmware corruption problems
with ext3/ext4 the whole time those RAID10 arrays existed.  Alas, we were
not capturing firmware revision data at the time (only vendor/model),
and we only started capturing firmware revisions after all the old
drives were recycled.  I don't know exactly what firmware versions were
in those arrays...though I do have a short list of suspects.  ;)

> Btrfs is relying more the hardware to implement barrier/flush properly,
> or CoW can be easily ruined.
> If the firmware is only tested (if tested) against such fs, it may be
> the problem of the vendor.
[...]
> > WD Green and Black are low-cost consumer hard drives under $250.
> > One drive of each size in both product ranges comes to a total price
> > of around $1200 on Amazon.  Lots of end users will have these drives,
> > and some of them will want to use btrfs, but some of the drives apparen=
tly
> > do not have working write caching.  We should at least know which ones
> > those are, maybe make a kernel blacklist to disable the write caching
> > feature on some firmware versions by default.
>=20
> To me, the problem isn't for anyone to test these drivers, but how
> convincing the test methodology is and how accessible the test device
> would be.
>=20
> Your statistic has a lot of weight, but it takes you years and tons of
> disks to expose it, not something can be reproduced easily.
>
> On the other hand, if we're going to reproduce power failure quickly and
> reliably in a lab enivronment, then how?
> Software based SATA power cutoff? Or hardware controllable SATA power cab=
le?

You might be overthinking this a bit.  Software-controlled switched
PDUs (or if you're a DIY enthusiast, some PowerSwitch Tails and a
Raspberry Pi) can turn the AC power on and off on a test box.  Get a
cheap desktop machine, put as many different drives into it as it can
hold, start writing test patterns, kill mains power to the whole thing,
power it back up, analyze the data that is now present on disk, log the
result over the network, repeat.  This is the most accurate simulation,
since it replicates all the things that happen during a typical end-user's
power failure, only much more often.  Hopefully all the hardware involved
is designed to handle this situation already.  A standard office PC is
theoretically designed for 1000 cycles (200 working days over 5 years)
and should be able to test 60 drives (6 SATA ports, 10 sets of drives
tested 100 cycles each).  The hardware is all standard equipment in any
IT department.

You only need special-purpose hardware if the general-purpose stuff
is failing in ways that aren't interesting (e.g. host RAM is corrupted
during writes so the drive writes garbage, or the power supply breaks
before 1000 cycles).  Some people build elaborate hard disk torture
rigs that mess with input voltages, control temperature and vibration,
etc. to try to replicate the effects effects of aging, but these setups
aren't representative of typical end-user environments and the results
will only be interesting to hardware makers.

We expect most drives to work and it seems that they do most of the
time--it is the drives that fail most frequently that are interesting.
The drives that fail most frequently are also the easiest to identify
in testing--by definition, they will reproduce failures faster than
the others.

Even if there is an intermittent firmware bug that only appears under
rare conditions, if it happens with lower probability than drive hardware
failure then it's not particularly important.  The target hardware failure
rate for hard drives is 0.1% over the warranty period according to the
specs for many models.  If one drive's hardware is going to fail
with p < 0.001, then maybe the firmware bug makes it lose data at p =3D
0.00075 instead of p =3D 0.00050.  Users won't care about this--they'll
use RAID to contain the damage, or just accept the failure risks of a
single-disk system.  Filesystem failures that occur after the drive has
degraded to the point of being unusable are not interesting at all.

> And how to make sure it's the flush/fua not implemented properly?

Is it necessary?  The drive could write garbage on the disk, or write
correct data to the wrong physical location, when the voltage drops at
the wrong time.  The drive electronics/firmware are supposed to implement
measures to prevent that, and who knows whether they try, and whether
they are successful?  The data corruption that results from the above
events is technically not a flush/fua failure, since it's not a write
reordering or a premature command completion notification to the host,
but it's still data corruption on power failure.

Drives can fail in multiple ways, and it's hard (even for hard disk
engineering teams) to really know what is going on while the power supply
goes out of spec.  To an end user, it doesn't matter why the drive fails,
only that it does fail.  Once you have *enough* drives, some of them
are always failing, and it just becomes a question of balancing the
different risks and mitigation costs (i.e. pick a drive that doesn't
fail so much, and a filesystem that tolerates the failure modes that
happen to average or better drives, and maybe use RAID1 with a mix of
drive vendors to avoid having both mirrors hit by a common firmware bug).

To make sure btrfs is using flush/fua correctly, log the sequence of block
writes and fua/flush commands, then replay that sequence one operation
at a time, and make sure the filesystem correctly recovers after each
operation.  That doessn't need or even want hardware, though--it's better
work for a VM that can operate on block-level snapshots of the filesystem.

> It may take us quite some time to start a similar project (maybe need
> extra hardware development).
>=20
> But indeed, a project to do 3rd-party SATA hard disk testing looks very
> interesting for my next year hackweek project.
>=20
> Thanks,
> Qu
>=20
> >=20
> > A modestly funded deliberate search project could build a map of firmwa=
re
> > reliability in currently shipping retail hard drives from all three
> > big vendors, and keep it updated as new firmware revisions come out.
> > Sort of like Backblaze's hard drive reliability stats, except you don't
> > need a thousand drives to test firmware--one or two will suffice most of
> > the time [3].  The data can probably be scraped from end user reports
> > (if you have enough of them to filter out noise) and existing ops logs
> > (better, if their methodology is sound) too.
> >=20
> >=20
> >=20
> >> Thanks,
> >> Qu
> >=20
> > [1] Pedants will notice that some of these drive firmwares range in age
> > from 6 months to 7 years, and neither of those numbers is 5 years, and
> > the power failure rate is implausibly high for a data center environmen=
t.
> > Some of the devices live in offices and laptops, and the power failures
> > are not evenly distributed across the fleet.  It's entirely possible th=
at
> > some newer device in the 0-failures list will fail horribly next week.
> > Most of the NAS and DC devices and all the SSDs have not had any UNC
> > sector events in the fleet yet, and they could still turn out to be
> > ticking time bombs like the WD Black once they start to grow sector
> > defects.  The data does _not_ say that all of those 0-failure firmwares
> > are bug free under identical conditions--it says that, in a race to
> > be the first ever firmware to demonstrate bad behavior, the firmwares
> > in the 0-failures list haven't left the starting line yet, while the 2
> > firmwares in the multi-failures list both seem to be trying to _win_.
> >=20
> > [2] We had a few surviving Seagate Barracudas in 2016, but over 85% of
> > those built before 2015 had failed by 2016, and none of the survivors
> > are still online today.  In practical terms, it doesn't matter if a
> > pre-2015 Barracuda has correct power-failing write-cache behavior when
> > the drive hardware typically dies more often than the host's office has
> > power interruptions.
> >=20
> > [3] OK, maybe it IS hard to find WD Black drives to test at the _exact_
> > moment they are remapping UNC sectors...tap one gently with a hammer,
> > maybe, or poke a hole in the air filter to let a bit of dust in?
> >=20
> >>> After turning off write caching, btrfs can keep running on these prob=
lem
> >>> drive models until they get too old and broken to spin up any more.
> >>> With write caching turned on, these drive models will eat a btrfs eve=
ry
> >>> few months.
> >>>
> >>>
> >>>> Or even use ZFS instead...
> >>>>
> >>>> Am 11/06/2019 um 15:02 schrieb Qu Wenruo:
> >>>>>
> >>>>> On 2019/6/11 =E4=B8=8B=E5=8D=886:53, claudius@winca.de wrote:
> >>>>>> HI Guys,
> >>>>>>
> >>>>>> you are my last try. I was so happy to use BTRFS but now i really =
hate
> >>>>>> it....
> >>>>>>
> >>>>>>
> >>>>>> Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC=
 2019
> >>>>>> x86_64 x86_64 x86_64 GNU/Linux
> >>>>>> btrfs-progs v4.15.1
> >>>>> So old kernel and old progs.
> >>>>>
> >>>>>> btrfs fi show
> >>>>>> Label: none=C2=A0 uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS byt=
es used 4.58TiB
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=
=A0 1 size 7.28TiB used 4.59TiB path /dev/mapper/volume1
> >>>>>>
> >>>>>>
> >>>>>> dmesg
> >>>>>>
> >>>>>> [57501.267526] BTRFS info (device dm-5): trying to use backup root=
 at
> >>>>>> mount time
> >>>>>> [57501.267528] BTRFS info (device dm-5): disk space caching is ena=
bled
> >>>>>> [57501.267529] BTRFS info (device dm-5): has skinny extents
> >>>>>> [57507.511830] BTRFS error (device dm-5): parent transid verify fa=
iled
> >>>>>> on 2069131051008 wanted 4240 found 5115
> >>>>> Some metadata CoW is not recorded correctly.
> >>>>>
> >>>>> Hopes you didn't every try any btrfs check --repair|--init-* or any=
thing
> >>>>> other than --readonly.
> >>>>> As there is a long exiting bug in btrfs-progs which could cause sim=
ilar
> >>>>> corruption.
> >>>>>
> >>>>>
> >>>>>
> >>>>>> [57507.518764] BTRFS error (device dm-5): parent transid verify fa=
iled
> >>>>>> on 2069131051008 wanted 4240 found 5115
> >>>>>> [57507.519265] BTRFS error (device dm-5): failed to read block gro=
ups: -5
> >>>>>> [57507.605939] BTRFS error (device dm-5): open_ctree failed
> >>>>>>
> >>>>>>
> >>>>>> btrfs check /dev/mapper/volume1
> >>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
> >>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
> >>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
> >>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
> >>>>>> Ignoring transid failure
> >>>>>> extent buffer leak: start 2024985772032 len 16384
> >>>>>> ERROR: cannot open file system
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> im not able to mount it anymore.
> >>>>>>
> >>>>>>
> >>>>>> I found the drive in RO the other day and realized somthing was wr=
ong
> >>>>>> ... i did a reboot and now i cant mount anmyore
> >>>>> Btrfs extent tree must has been corrupted at that time.
> >>>>>
> >>>>> Full recovery back to fully RW mountable fs doesn't look possible.
> >>>>> As metadata CoW is completely screwed up in this case.
> >>>>>
> >>>>> Either you could use btrfs-restore to try to restore the data into
> >>>>> another location.
> >>>>>
> >>>>> Or try my kernel branch:
> >>>>> https://github.com/adam900710/linux/tree/rescue_options
> >>>>>
> >>>>> It's an older branch based on v5.1-rc4.
> >>>>> But it has some extra new mount options.
> >>>>> For your case, you need to compile the kernel, then mount it with "=
-o
> >>>>> ro,rescue=3Dskip_bg,rescue=3Dno_log_replay".
> >>>>>
> >>>>> If it mounts (as RO), then do all your salvage.
> >>>>> It should be a faster than btrfs-restore, and you can use all your
> >>>>> regular tool to backup.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>>
> >>>>>> any help
> >>
> >=20
> >=20
> >=20
>=20




--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXRBRogAKCRCB+YsaVrMb
nEZpAKCyD3m+cHEeg3d44WY5gpWpQsIDHQCeKTrbq59/R4BW9pv9asOY1HovI24=
=NFav
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
