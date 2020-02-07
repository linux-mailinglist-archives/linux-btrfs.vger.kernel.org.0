Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407451551A5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 05:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGE6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 23:58:24 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39236 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgBGE6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 23:58:23 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BE5F75B0F66; Thu,  6 Feb 2020 23:58:22 -0500 (EST)
Date:   Thu, 6 Feb 2020 23:58:22 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>
Cc:     Matt Zagrabelny <mzagrabe@d.umn.edu>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs-scrub: slow scrub speed (raid5)
Message-ID: <20200207045822.GF13306@hungrycats.org>
References: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
 <CAOLfK3UoH1akySt47Wg8JDDFCHqbcm8otZyEAPp1jX0Ye+41-w@mail.gmail.com>
 <CADkZQanf+--iDj3Y+toiRybPZC2UsCtbuCn7BQb6d8FeqLSeXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A9k63Mnmpo23fVdx"
Content-Disposition: inline
In-Reply-To: <CADkZQanf+--iDj3Y+toiRybPZC2UsCtbuCn7BQb6d8FeqLSeXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--A9k63Mnmpo23fVdx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 07:13:41PM +0100, Sebastian D=F6ring wrote:
> (oops, forgot to reply all the first time)
>=20
> > Is RAID5 stable? I was under the impression that it wasn't.
> >
> > -m
>=20
> Not sure, but AFAIK most of the known issues have been addressed.
>=20
> I did some informal testing with a bunch of usb devices, ripping them
> out during writes, remounting the array with a device missing in
> degraded mode, then replacing the device with a fresh one, etc. Always
> worked fine. Good enough for me. The scary write hole seems hard to
> hit, power outages are rare and if they happen I will just run a scrub
> immediately.

It's quite hard to hit the write hole for data.  A bunch of stuff has
to happen at the same time:

	- Writes have to be small.  btrfs actively tries to prevent this,
	but can be defeated by a workload that uses fsync().  Big writes
	will get their own complete RAID stripes, therefore no write hole.
	Writes smaller than a RAID stripe (64K * (number_of_disks -
	1)) will be packed into smaller gaps in the free space map,
	more of which will be colocated in RAID stripes with previously
	committed data.  This is good for collections of big media files,
	and bad for databases, VM images, and build trees.

	- The filesystem has to have partially filled RAID stripes, as
	the write hole cannot occur in an empty or full RAID stripe. [1]
	A heavily fragmented filesystem has more of these.  An empty
	filesystem (or a recently balanced one) has fewer.

	- Power needs to fail (or host crash) *during* a write
	that meets the other criteria.	Hosts that spend only 1%
	of their time writing will have write hole failures at 10x
	lower rates than hosts that spend 10% of their time writing.
	The vulnerable interval for write hole is very short--typically
	less than a millisecond--but if you are writing to thousands of
	raid stripes per second, then there are thousands of write hole
	windows per second.

	- Write hole can only affect a system in degraded mode, so
	after all the above, you're still only _at risk_ of a write
	hole failure--you also need a disk fault to occur before you
	can repair parity with a scrub.

It is harder to meet these conditions for data, but it's the common
case for metadata.  Metadata is all 16K writes and the 'nossd' allocator
perversely prefers partially-filled RAID stripes.  btrfs spends a _lot_
of its time doing metadata writes.  This maximizes all the prerequisites
above.  btrfs has zero tolerance for uncorrectable metadata loss, so
raid5 and raid6 should never be used for metadata.  Adding the 'nossd'
mount option will make total filesystem loss even faster.

In practice, btrfs raid5 data with raid1 metadata fails (at least one
block unreadable) about once per 30 power failures or crashes while
running a write stress test designed to maximize the conditions listed
above.  I'm not sure if all of that failure rate is due to write hole
or other currently active btrfs raid5 bugs--we'd have to fix the other
bugs and measure the change in failure rate to know.

If your workload doesn't meet the above criteria then the failure rates
will be lower.  A light-duty SOHO file sharing server will probably
last 5 years between data losses with a disk fault every 2.5 years;
however, if you put a database or VM host on that server than it might
have losses on almost every power failure.  The rate you will experience
depends on your workload.  As long as metadata is raid1, 10, 1c3 or 1c4,
the data losses which do occur due to write hole will be small, and can
be recovered by deleting and replacing the damaged files from backups.


[1] except in nodatacow and prealloc files; however, nodatacow is
basically a flag that says "please allow my data to be corrupted as much
as possible without intentionally destroying it," so this is expected.
Prealloc prevents the allocator from avoiding partially filled RAID
stripes because it forces logically consecutive writes to be physically
consecutive as well.

--A9k63Mnmpo23fVdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjzuawAKCRCB+YsaVrMb
nLEKAJ96H03PzDBdgmuH8oJBtJv5ZO9vbQCeP1fznpwPljHGRdUOxjInkcVsM0Q=
=rABc
-----END PGP SIGNATURE-----

--A9k63Mnmpo23fVdx--
