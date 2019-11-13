Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5624CFA752
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 04:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKMDeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 22:34:09 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47808 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMDeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 22:34:09 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 72B064CDFFB; Tue, 12 Nov 2019 22:34:06 -0500 (EST)
Date:   Tue, 12 Nov 2019 22:34:06 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: checksum errors in orphaned blocks on multiple systems (Was: Re:
 Decoding "unable to fixup (regular)" errors)
Message-ID: <20191113033406.GX22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold>
 <20191108220927.GR22121@hungrycats.org>
 <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at>
 <20191108222557.GT22121@hungrycats.org>
 <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at>
 <20191108233933.GU22121@hungrycats.org>
 <1535877515.79035.1573293506680.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline
In-Reply-To: <1535877515.79035.1573293506680.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2019 at 10:58:26AM +0100, Richard Weinberger wrote:
> While investigating I found two more systems with the same symptoms.
>=20
> Please let me share my findings:

Thanks for these.  Some further questions below.

> 1. Only orphaned blocks show checksum errors, no "active" inodes are affe=
cted.
>=20
> 2. The errors were logged first a long time ago (more than one year), che=
cked my logs.
>    I get alarms for most failure, but not for "BTRFS error" strings in dm=
esg.
>    But this explains why I didn't notice for such a long time.
>    Yes, shame on me, I need to improve my monitoring.
>=20
> 3. All systems run OpenSUSE 15.0 or 15.1. But the btrfs filesystems were =
created at times
>    of OpenSUSE 42.2 or older, I do regularly distro upgrades.
>=20
> 4. While my hardware is not new it should be good. I have ECC-Memory,
>    enterprise disks. Every disk spasses SMART checks, etc...
>=20
> 5. Checksum errors are only on systems with an md-RAID1, I run btrfs on m=
ost other
>    servers and workstations. No such errors there.
>=20
> 6. All systems work. These are build servers and/or git servers. If files=
 would turn bad
>    there is a good chance that one of my developers will notice an applic=
ation failure.
>    e.g. git will complain, reproducible builds are not reproducible anymo=
re, etc...
>    So these are not file servers where files are written once and never r=
ead again.
>=20
> Zygo Blaxell pointed out that such errors can be explained by silent fail=
ures of
> my disks and the nature of md-RAID1.

Now that you've provided some more data I can rule out some potential
causes and refine this:  system 3 looks like misplaced writes due to
head positioning error--the spacing is consistent with 3 errors on 3
platters, same track, and 768 seems reasonable as a sector count (would
give a transfer rate of 188MB/s, in the right range for somewhere in the
middle of the disc).  The other systems have more randomly distributed
error locations, but multiple corruption events are possible (there is
rarely just one during the service life of a bad drive).

The data set is still small--only a handful of blocks on each system--so
we can't rule out a wide variety of other root causes; however, we have
no evidence to support them either.

Do you know what data is in the bad csum orphan blocks?  Does that data
belong in the same extent or file as the good csum orphan blocks?

> But how big is the chance that this happens on *three* independent system=
s and only
> orphaned blocks are affected?

The systems are not independent:  same drive models in each md-raid1
pair, same drive models in 2 of 3 systems, vendor monoculture in all 3.
We can expect drive behavior to be very similar under those conditions,
so if one drive is acting up, chances are good at least 2 of the other
5 will be acting up too.

The probability of failure wouldn't be low even if they were independent.
mdadm propagation of error from one disk to the other p =3D 0.5, data
loss on WD drives built in 2011-2016 p > 0.05 per year (increasing as
drives age).  For 6 disks in 2 years that's a 27% chance of having at
least one failure.  Some of those failures will be detected by SMART
or mdadm, some will not.  The ones that are not detected will look like
what you've observed.

The WD1003FBYX model dates back to 2011 and if I have my EOL dates right,
every drive of that model is out of warranty by now.  It happens to be the
disk used in the system with the most errors reported.  No surprise there.

How many power-on hours do your drives have?  What are their manufacturing
years?  Compare these with the ages and device models in your systems
that are not experiencing corruption.

> Even if all of my disks are bad and completely lying to me,=20

Your logs are what that event looks like.

Real enterprise drives (as opposed desktop drives with a few upgraded
components and "enterprise" written on the label) don't rely on the
hard disk firmware for data integrity at all--they pass sector CRCs and
other metadata in-band from the platter to the host.  Nothing in the
higher layers trusts anything it gets from the lower layers, unless
the lower layer is saying "nope, I'm really broken, go on without me."

It's far cheaper and more reliable to run something like ZFS or btrfs
or proprietary FS on top of the drives, to catch the failures that are
difficult and expensive to detect in the drive itself.  Checking outside
the drive also catches firmware bugs, which firmware can't detect by
definition.

> I'd still expect that
> the errors are distributed across all type of blocks (used data, orphaned=
 data, tree, ...).

Normally when disks go corrupt we see errors distributed across all
block types in proportion to the number or update frequency of each type.
Data blocks outnumber other block types by 3 orders of magnitude, so a
random read failure or single random write failure will almost always
affect data blocks.  Data blocks and tree blocks are physically separated
by large distances (multiples of 1GB) in btrfs, so even if a write misses
a data block, it will typically land on some other data block or a free
block, not a tree block.  If it's an issue related to aging hardware
(bit fade or misplaced writes), older extents will fail more than newer
extents as there is more time for decay to happen to them before they
are rewritten with fresh data.

If your log data below is complete, you have a small number of corrupted
blocks on each drive, so there isn't enough data to say that there won't
eventually be errors in other block types in the future.  You should
watch for these, or better, convert your filesystems to btrfs raid1 to
keep logs of corruption detection events and correct them automatically
when they do occur.

The corruption pattern could be the result of a small number of
misdirected writes on each disk (assuming the failure data reported is
complete).  One of them even looks like it might be caused by a single
write:  3 blocks are equally spaced 768x512 sectors apart, a perfect fit
for a 2-platter hard drive with a one-off head wobble during a write.
That data arrangement makes other hardware failure modes like drive RAM
failure seem less likely--most RAM failures will cause effects separated
by power-of-2 or random distances, not a multiple of 3, and even a random
3 is unlikely to occur twice in the same megabyte.

Orphan blocks are generally older than other blocks (not always,
but the large-scale frequency distribution tends in that direction).
Orphan blocks appear in long-lived inodes like VM filesystem images and
database files.  Orphan blocks don't appear in short-lived inodes like git
source checkouts (or git files in general for that matter--git gc rewrites
all the pack files by default every few weeks) or build server artifacts.
This means that orphan blocks will be among the oldest blocks on the
filesystem, and therefore more likely than other blocks to be corrupted
by phenomena related to drive aging.

You can estimate the age of a block by reading the 'gen' field of its
containing extent.  This starts at 1 and increments by 1 with each
transaction commit in the filesystem.

What files are referencing the extents with the orphan blocks that have
csum errors?  Are they long-lived inodes, or recently created files?

> A wild guess from my side:
> Could it be that there was a bug in old (OpenSUSE) kernels which causes o=
rphaned
> blocks to have bad checksums?=20

This is very unlikely.  Orphaned blocks are not (and cannot be) treated
specially by scrub or balance, so there is no mechanism in btrfs that
could harbor a bug in scrub or balance that is specific to orphaned
blocks.  Historically, the few bugs so far that have affected scrub
or balance data integrity at all also caused severe metadata damage
fairly quickly--the scrub/balance failures are just a side-effect of
the destruction of the filesystem.

Orphaned blocks do not start as orphans.  The blocks are initially
populated with reachable data, so they had to have correct csums at
some point (assuming host RAM ECC is working, and ignoring some subtle
details about prealloc blocks that don't matter).  If they had bad csums
at the beginning (before they were orphans), there would be kernel logs
and application errors when the data is read, but you report that no such
errors have been observed.  This observation also rules out lost writes as
a possible cause--in the lost write case, the csum is initially correct
but the matching data write is lost, so an error would be observed by
applications and reported by btrfs on the very next uncached read.

If the data is overwritten later, btrfs creates a new extent to
replace parts of the old extent, but does not remove or modify the old
extent until the last reference to any block is gone (btrfs extents
are immutable).  Once written to disk, nothing in btrfs touches the
extent data or csum items.  The csum metadata pages do get rewritten
when any new data is written to adjacent physical locations, but the
items themselves are not modified.  There is a risk of corruption of
the csum items during copies and IO of the metadata page, but you have
ECC RAM so that's probably OK.  Even if the ECC RAM wasn't OK or there
was a kernel data corruption bug, random corruption of metadata items
would break the filesystem fairly quickly and visibly, it would not be
an obscure phenomenon restricted to a handful of orphan data blocks that
goes unnoticed for a year.

csum tree metadata pages are protected against bit-level corruption by
page-level CRCs, against lost or misdirected writes by ID and parent/child
transid fields, and against host RAM errors by your use of ECC RAM.
If any of those were breaking, you should be seeing the effects scattered
across the entire filesystem, especially on metadata pages due to high
memory persistence and frequent updates.

I have filesystems with unusually large numbers of orphaned blocks
(in pathological dedupe cases, sometimes 2/3 of the disk surface ends
up in orphan blocks).  If btrfs somehow had a 3-year-old bug in scrub
that specialized in orphan blocks, it should have shown up in testing
many times by now.

> Maybe only when combined with md-RAID?

Well, obviously md-raid1 will make data corruption more likely--it
combines the corruption risk of two drives with no mechanism
to mitigate that risk (other than looking at arcane data in
/sys/block/*/md/mismatch_cnt).

We expect double the silent data corruption failure rate on md-raid1
compared to a single disk, assuming perfect software implementation and
all other variables being equal.  This is because you have two disks that
could corrupt data instead of one, and the disks will not inform mdadm
of this corruption by the definition of silent data corruption.  You can
also get other interesting effects like non-repeatable reads--btrfs
won't be bothered much by those, but ext4 and xfs can get very confused.

There could *also* be implementation bugs.  The md(4) man page describes
situations where inconsistencies could occur for swap pages on md-raid1.
This shouldn't affect btrfs in the way you've reported because:

	- btrfs cannot allow concurrent page updates during writes on
	datasum files, as any concurrent page update would break csums.
	A bug there should be affecting non-orphan blocks too.	It won't
	matter what the lower storage layer is.  If this problem exists
	everyone should be seeing it.

	- nodatacow could allow concurrent page modification (not saying
	it does, just that allowing this doesn't immediately and noisily
	break btrfs) but even if it did, there is no csum to verify
	in this case.  We can't get from here to the reported scrub or
	balance errors because those errors require a csum.

	- swap on btrfs is not available in your reported 4.4..4.12
	kernel rage (introduced in 5.0) and is based on a nodatacow file
	(same as above).

md-raid1 features like write-intent bitmaps can interact with device
firmware bugs in unexpected ways.  Usually both behaviors are incorrect,
but the behavior with md-raid1 could in theory be different from an
otherwise identical setup without md-raid1.

But...who would bother to test that?  md-raid1 seems like a silly idea,
don't use it if you could use btrfs raid1 instead.

> Maybe discard plays a role too...

Discard shouldn't be involved unless there is a SSD, thin LV, or cache
device that you haven't mentioned yet.  These are not SMR drives, there
is no LBA to physical translation table (other than the redirection list
for bad blocks).  Normal hard disks aren't structured in a way that
enables discard to have any effect.

> System 1:
>=20
> [10860370.764595] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 593483341824 on dev /dev/md1
> [10860395.236787] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2292, gen 0
> [10860395.237267] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595304841216 on dev /dev/md1
> [10860395.506085] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2293, gen 0
> [10860395.506560] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595326820352 on dev /dev/md1
> [10860395.511546] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2294, gen 0
> [10860395.512061] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595327647744 on dev /dev/md1
> [10860395.664956] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2295, gen 0
> [10860395.664959] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595344850944 on dev /dev/md1
> [10860395.677733] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2296, gen 0
> [10860395.677736] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595346452480 on dev /dev/md1
> [10860395.770918] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2297, gen 0
> [10860395.771523] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595357601792 on dev /dev/md1
> [10860395.789808] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2298, gen 0
> [10860395.790455] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595359870976 on dev /dev/md1
> [10860395.806699] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2299, gen 0
> [10860395.807381] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595361865728 on dev /dev/md1
> [10860395.918793] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2300, gen 0
> [10860395.919513] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595372343296 on dev /dev/md1
> [10860395.993817] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2301, gen 0
> [10860395.994574] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595384438784 on dev /dev/md1
>=20
> md1 is RAID1 of two WDC WD1003FBYX-01Y7B1
>=20
> System 2:
>=20
> [2126822.239616] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0=
, flush 0, corrupt 13, gen 0
> [2126822.239618] BTRFS error (device md0): unable to fixup (regular) erro=
r at logical 782823940096 on dev /dev/md0
> [2126822.879559] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0=
, flush 0, corrupt 14, gen 0
> [2126822.879561] BTRFS error (device md0): unable to fixup (regular) erro=
r at logical 782850768896 on dev /dev/md0
> [2126823.847037] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0=
, flush 0, corrupt 15, gen 0
> [2126823.847039] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0=
, flush 0, corrupt 16, gen 0
> [2126823.847041] BTRFS error (device md0): unable to fixup (regular) erro=
r at logical 782960300032 on dev /dev/md0
> [2126823.847042] BTRFS error (device md0): unable to fixup (regular) erro=
r at logical 782959267840 on dev /dev/md0
> [2126837.062852] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0=
, flush 0, corrupt 17, gen 0
> [2126837.062855] BTRFS error (device md0): unable to fixup (regular) erro=
r at logical 784446283776 on dev /dev/md0
> [2126837.071656] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0=
, flush 0, corrupt 18, gen 0
> [2126837.071658] BTRFS error (device md0): unable to fixup (regular) erro=
r at logical 784446230528 on dev /dev/md0
>=20
> md0 is RAID1 of two WDC WD3000FYYZ-01UL1B1
>=20
> System 3:
>=20
> [11470830.902308] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd =
0, flush 0, corrupt 80, gen 0
> [11470830.902315] BTRFS error (device md0): unable to fixup (regular) err=
or at logical 467063083008 on dev /dev/md0
> [11470830.967863] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd =
0, flush 0, corrupt 81, gen 0
> [11470830.967867] BTRFS error (device md0): unable to fixup (regular) err=
or at logical 467063087104 on dev /dev/md0
> [11470831.033057] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd =
0, flush 0, corrupt 82, gen 0
> [11470831.033062] BTRFS error (device md0): unable to fixup (regular) err=
or at logical 467063091200 on dev /dev/md0
>=20
> md1 is RAID1 of two WDC WD3000FYYZ-01UL1B3
>=20
> Thanks,
> //richard

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXct5rgAKCRCB+YsaVrMb
nEcrAKCNLSB1vALpG7xDiwkuSyWKmOSHYACfeis8LvnnEitHW5lBIYnDzOVNwog=
=ddtl
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--
