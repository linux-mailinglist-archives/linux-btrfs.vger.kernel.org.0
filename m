Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743855DD8B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 06:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfGCEo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 00:44:28 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34258 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbfGCEo2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 00:44:28 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 00:44:28 EDT
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DD3973732C9; Wed,  3 Jul 2019 00:37:21 -0400 (EDT)
Date:   Wed, 3 Jul 2019 00:37:21 -0400
From:   Zygo Blaxell <zblaxell@furryterror.org>
To:     Pierre Couderc <pierre@couderc.eu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: What are the maintenance recommendation ?
Message-ID: <20190703043721.GJ11831@hungrycats.org>
References: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bgQAstJ9X1Eg13Dy"
Content-Disposition: inline
In-Reply-To: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--bgQAstJ9X1Eg13Dy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2019 at 08:50:03PM +0200, Pierre Couderc wrote:
> 1- Is there a summary of btrfs recommendations for maintenance ?
>=20
> I have read somewhere that=A0 a monthly=A0 btrfs scrub is recommended.=20

1.  Scrub detects and (when using the DUP or RAID1/10/5/6 profiles)
corrects errors introduced into the filesystem by failures in the
underlying disks.  You can run scrub as much or as little as you want,
but the longer you go between scrubs, the longer errors can accumulate
undetected, and the greater the risk that you'll have uncorrected errors
on multiple disks when one of your disks fails and needs to be replaced.
In that event, you will lose data or even the entire filesystem.

The ideal frequency for scrubs depends in part on how important your data
is.  If it's very important that you detect storage failures immediately,
you can run scrub once a day.  If the data is very unimportant--e.g. you
have good backups, and you don't care about extended downtime to restore
them--then you might not need to run scrub at all.

I run alternating SMART long self-tests and btrfs scrubs every 15 days
(i.e. SMART long self-tests every 30 days, btrfs scrub 15 days after
every SMART long self-test).

Note that after a power failure or unclean shutdown, you should run
scrub as soon as possible after rebooting, regardless of the normal
maintenance schedule.  This is especially important for RAID5/6 profiles
to regenerate parity blocks that may have been damaged by the parity
raid write hole issue.  A post-power-failure scrub can also detect some
drive firmware bugs.

Pay attention to the output of scrub, especially the per-device statistics
(btrfs scrub status -d and btrfs dev stat).  Errors reported here will
indicate which disks should be replaced in RAID arrays.

2.  Watch the amount of "unallocated" space on the filesystem.  If the
"unallocated" space (shown in 'btrfs fi usage') drops below 1GB, you are
at risk of running out of metadata space.  If you run out of metadata
space, btrfs becomes read-only and it can be difficult to recover.

To free some unused data space (convert it from "data" to "unallocated"):

	btrfs balance start -dlimit=3D5 /path/to/fs

This usually doesn't need to be done more than once per day, but it
depends on how busy your filesystem is.  If you have hundreds of GB of
unallocated space then you won't need to do this at all.

Never balance metadata (i.e. the -m option of btrfs balance) unless you
are converting to a different RAID profile (e.g. -mconvert=3Draid1,soft).
If there is sufficient metadata space allocated, then the filesystem
can be filled with data without any problems.  Balancing metadata can
reduce the amount of space allocated for metadata, then the filesystem
will be at risk of going read-only if it fills up.

Normally there will be some overallocation of metadata (roughly 3:2
allocated:used ratio).  Leave it alone--if the filesystem allocated
metadata space in the past, the filesystem may need it again in the
future.

Scrub and balancing are the main requirements.  Filesystems can operate
with just those two maintenance actions for years (outlasting all of
their original hardware), and recover from multiple disk failures (one
at a time) along the way.

> Is there
> somewhere a reference,=A0 an "official" (or not...) guide of all=A0 that=
=A0 is
> recommended ?

There probably should be...

> I am lost in the wiki...
>=20
> 2- Is there a repair guide ? I see all these commands restore, scrub,
> rescue. Is there a guide of what to do when a disk has some errors ? The =
man
> does not say when use some command...

A scrub can fix everything that btrfs kernel code can recover from, i.e.
if a disk in a btrfs RAID array is 100% corrupted while online, scrub
can restore all of the data, including superblocks, without interrupting
application activity on the filesystem.  With RAID1/5/6/10 this includes
all single-disk failures and non-malicious data corruption from disks
(RAID6 does not have a corresponding 3-copy RAID1 profile for metadata
yet, so RAID6 can't always survive 2 disk failures in practice).

Scrub is very effective at repairing data damage caused by disk failures
in RAID arrays, and with DUP metadata on single-disk filesystem scrub can
often recover from a few random UNC sectors.  If something happens to the
filesystem that scrub can't repair (e.g. damage caused by accidentally
overwriting the btrfs partition with another filesystem, host RAM failures
writing corrupted data to disks, hard drive firmware write caching bugs),
the other tools usually can't repair it either.

Always use DUP or RAID1 or RAID10 for metadata.  Do not use single, RAID0,
RAID5, or RAID6--if there is a UNC sector error or data corruption in
a metadata page, the filesystem will be broken, and data losses will be
somewhere between "medium" and "severe".

The other utilities like 'btrfs check --repair' are in an experimental
state of development, and may make a damaged filesystem completely
unreadable.  They should only be used as a last resort, with expert
guidance, after all other data recovery options have been tried, if
at all.  Often when a filesystem is damaged beyond the ability of scrub
to recover, the only practical option is to mkfs and start over--but
ask the mailing list first to be sure, doing so might help improve the
tools so that this is no longer the case.

Usually a damaged btrfs can still be mounted read-only and some data
can be recovered.  Corrupted data blocks (with non-matching csums) are
not allowed to be read through a mounted filesystem.  'btrfs restore'
is required to read those.

'btrfs restore' can copy data from a damaged btrfs filesystem that is
not mounted.  It is able to work in some cases where mounting fails.
When 'btrfs restore' copies data it does not verify csums.  This can be
used to recover corrupted data that would not be allowed to read through
a mounted filesystem.  On the other hand, if you want to avoid copying
data with known corruption, you should mount the filesystem read-only
and read it that way.

Use 'btrfs replace' to replace failed disks in a RAID1/RAID5/RAID6/RAID10
array.  It can reconstruct data from other mirror disks quickly by
simply copying the mirrored data without changing any of the filesystem
structure that references the data.  If the replacement disk is smaller
than the disk it is meant to replace, then use 'btrfs dev add' followed by
'btrfs dev remove', but this is much slower as the data has to be moved
one extent at a time, and all references to the data must be updated
across the array.

There appear to be a few low-end hard drive firmwares in the field with
severe write caching bugs.  The first sign that you have one of those is
that btrfs gets an unrecoverable 'parent transid verify failure' event
after a few power failures.  The only known fix for this is to turn off
write caching on such drives (i.e. hdparm -W0), mkfs, and start over.
If you think you have encountered one of these, please post to the
mailing list with drive model and firmware revision.

'btrfs rescue' is useful for fixing bugs caused by old mkfs tools or
kernel versions.  It is not likely you will ever need it if you mkfs a
new btrfs today (though there's always the possibility of new bugs in
the future...).

>=20
> Erros occurs fairly often on big disks...
>=20
> Thanks
>=20
> PC
>=20

--bgQAstJ9X1Eg13Dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXRwxAQAKCRCB+YsaVrMb
nEgHAJ9XyTiI04C8Sf1ZSTCPNgVSrlLFRACgrWznf7OunCi9t0R4F5ezpKxv0Wk=
=NADO
-----END PGP SIGNATURE-----

--bgQAstJ9X1Eg13Dy--
