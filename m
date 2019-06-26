Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A455E62
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 04:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFZCa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 22:30:28 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36130 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZCa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 22:30:28 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 71380361D32; Tue, 25 Jun 2019 22:30:27 -0400 (EDT)
Date:   Tue, 25 Jun 2019 22:30:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery
 not possible)
Message-ID: <20190626023027.GF11831@hungrycats.org>
References: <20190623204523.GC11831@hungrycats.org>
 <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
 <CAJCQCtRrT5pUxOxfKWTC=zt9E=ZxRaiLeBxngqc6YVQEYp8n_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <CAJCQCtRrT5pUxOxfKWTC=zt9E=ZxRaiLeBxngqc6YVQEYp8n_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 11:31:35AM -0600, Chris Murphy wrote:
> On Sun, Jun 23, 2019 at 7:52 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2019/6/24 =E4=B8=8A=E5=8D=884:45, Zygo Blaxell wrote:
> > > I first observed these correlations back in 2016.  We had a lot of WD
> > > Green and Black drives in service at the time--too many to replace or
> > > upgrade them all early--so I looked for a workaround to force the
> > > drives to behave properly.  Since it looked like a write ordering iss=
ue,
> > > I disabled the write cache on drives with these firmware versions, and
> > > found that the transid-verify filesystem failures stopped immediately
> > > (they had been bi-weekly events with write cache enabled).
> >
> > So the worst scenario really happens in real world, badly implemented
> > flush/fua from firmware.
> > Btrfs has no way to fix such low level problem.
>=20
> Right. The questions I have: should Btrfs (or any file system) be able
> to detect such devices and still protect the data? i.e. for the file
> system to somehow be more suspicious, without impacting performance,
> and go read-only sooner so that at least read-only mount can work?=20

Part of the point of UNC sector remapping, especially in consumer
hard drives, is that filesystems _don't_ notice it (health monitoring
daemons might notice SMART events, but it's intentionally transparent to
applications and filesystems).  The alternative is that one bad sector
throws an application that is not prepared to handle it, or forces the
filesystem RO, or triggers a full-device RAID data rebuild.

Of course that all goes sideways if the firmware loses its mind (and
write cache) during UNC sector remapping.

> Or is this so much work for such a tiny edge case that it's not worth it?
>=20
> Arguably the hardware is some kind of zombie saboteur. It's not
> totally dead, it gives the impression that it's working most of the
> time, and then silently fails to do what we think it should in an
> extraordinary departure from specs and expectations.

> Are there other failure cases that could look like this and therefore
> worth handling?=20

In some ways firmware bugs are just another hardware failure.  Hard disks
are free to have any sector unreadable at any time, or one day the
entire disk could just decide not to spin up any more, or non-ECC
RAM in the embedded controller board could flip some bits at random.
These are all standard failure modes that btrfs detects (and, with an
intact mirror available, automatically corrects).

Firmware bugs are different quantitatively:  they turn
common-but-recoverable failure events into common-and-catastrophic
failure events.  Most people expect catastrophic failure events to
be less common, but manufacturing is hard, and sometimes they are not.
Entire production runs of hard drives can die early due to a manufacturing
equipment miscalibration or a poor choice of electrical component.

> As storage stacks get more complicated with ever more
> complex firmware, and firmware updates in the field, it might be
> useful to have at least one file system that can detect such problems
> sooner than others and go read-only to prevent further problems?

I thought we already had one:  btrfs.  Probably ZFS too.

The problem with parent transid verify failure is that the problem is
detected after the filesystem is already damaged.  It's too late to go
RO then, you need a time machine to get the data back.

We could maybe make some more pessimistic assumptions about how stable
new data is so that we can recover from damage in new data far beyond what
flush/fua expectations permit.  AFAIK the Green only fails during a
power failure, so btrfs could keep the last N filesystem transid trees
intact at all times, and during mount btrfs could verify the integrity
of the last transaction and roll back to an earlier transid if there
was a failure.  This has been attempted before, and it has various new
ENOSPC failure modes, and it requires modifications to some already
very complex btrfs code, but if we waved a magic wand and a complete,
debugged implementation of this appeared with a reasonable memory and/or
iops overhead, it would work on the Green drives.

The WD Black is a different beast:  some sequence of writes is lost
when a UNC sector is encountered, but the drive doesn't report the loss
immediately (if it did, btrfs would already go RO before the end of the
transaction, and the metadata tree would remain intact).  The loss is
only detected some time after, during reads which might be thousands of
transids later. =20

Both of these approaches have a problem:  when the workaround is used,
the filesystem rolls back to an earlier state, including user data.
In some cases that might not be a good thing, e.g. rolling back 1000
transids on a mail store or OLTP database, or rolling back datacow
files while _not_ rolling back nodatacow files.

btrfs already writes two complete copies of the metadata with dup
metadata, but firmware bugs can kill both copies.  btrfs could hold the
last 256MB of metadata writes in RAM (or whatever amount of RAM is bigger
than the drive cache), and replay those writes or verify the metadata
trees whenever a bad sector is reported or the drive does a bus reset.
This would work if the write cache is dropped during a read, but if the
firmware silently drops the write cache while remapping a UNC sector then
btrfs will not be able to detect the event and would not know to replay
the write log.  This kind of solution seems expensive, and maybe a little
silly, and might not even work against all possible drive firmware bugs
(what if the drive indefinitely postpones some writes, so 256MB isn't
enough RAM log?).

Also, a more meta observation:  we don't know this is what is really
happening in the firmware.  There are clearly problems observed
when multiple events occur currently, but there are several possible
mechanisms that could lead to the behavior, and nowhere in my data is
enough information to determine which one is correct.  So if a drive
has a firmware bug that just redirects a cache write to an entirely
random address on the disk (e.g. it corrupts or overruns an internal RAM
buffer) the symptoms will match the observed behavior, but none of these
workaround strategies will work.  You'd need to have a RAID1 mirror in a
different disk to protect against arbitrary data loss anywhere in a
single drive--and btrfs can already support that because it's a normal
behavior for all hard drives.

The cost of these workarounds has to be weighed against the impact
(how many drives are out there with these firmware bugs) and compared
with the cost of other solutions that already exist.  A heterogeneous
RAID1 solves this problem--unless you are unlucky and get two different
firmwares with the same bug.

It may be possible that the best workaround is also the simplest, and also
works for all filesystems at once:  turn the write cache off for drives
where it doesn't work.  CoW filesystems write in big contiguous sorted
chunks, and that gets most of the benefit of write reordering before the
drive gets the data, so there is less to lose if the drive cannot reorder.
An overwriting filesystem writes in smaller, scattered chunks with more
seeking, and can get more benefit from write caching in the drive.

> > BTW, do you have any corruption using the bad drivers (with write cache)
> > with traditional journal based fs like XFS/EXT4?
> >
> > Btrfs is relying more the hardware to implement barrier/flush properly,
> > or CoW can be easily ruined.
> > If the firmware is only tested (if tested) against such fs, it may be
> > the problem of the vendor.
>=20
> I think we can definitely say this is a vendor problem. But the
> question still is whether the file system as a role in at least
> disqualifying hardware when it knows it's acting up before the file
> system is thoroughly damaged?

How does a filesystem know the device is acting up without letting the
device damage the filesystem first?  i.e. how do you do this without
maintaining a firmware revision blacklist?  Some sort of extended
self-test during mkfs?  Or something an admin can run online, like a
balance or scrub?  That would not catch the WD Black firmware revisions
that need a bad sector to make the bad behavior appear.

> I also wonder how ext4 and XFS will behave. In some ways they might
> tolerate the problem without noticing it for longer, where instead of
> kernel space recognizing it, it's actually user space / application
> layer that gets confused first, if it's bogus data that's being
> returned. Filesystem metadata is a relatively small target for such
> corruption when the file system mostly does overwrites.

The worst case on those filesystems is less bad than btrfs (for the
filesystem--the user data is trashed in ways that are not reported and
might be difficult to detect).

btrfs checks everything--metadata and user data--and stops when
unrecoverable failure is detected, so the logical result is that btrfs
stops on firmware bugs.  That's a design feature or horrible flaw,
depending on what the user's goals are.

ext4 optimizes for availability and performance (simplicity ended with
ext3) and intentionally ignores some possible failure modes (ext4 makes no
attempt to verify user data integrity at all, and even metadata checksums
are optional).  XFS protects itself similarly, but not user data.

> I also wonder how ZFS handles this. Both in the single device case,
> and in the RAIDZ case.
>=20
>=20
> --=20
> Chris Murphy

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXRLYwAAKCRCB+YsaVrMb
nFqXAKCPrcMBd/bA4wqi5V/ajYf6pWLehgCgyoaY8V0T0PbGsdeUnvSpHauXeJc=
=Wbxg
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
