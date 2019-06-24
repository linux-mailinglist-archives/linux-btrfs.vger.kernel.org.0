Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0974E500FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFXF1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 01:27:19 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35642 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbfFXF1T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 01:27:19 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id F0C9535CE68; Mon, 24 Jun 2019 01:27:18 -0400 (EDT)
Date:   Mon, 24 Jun 2019 01:27:18 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery
 not possible)
Message-ID: <20190624052718.GD11831@hungrycats.org>
References: <20190623204523.GC11831@hungrycats.org>
 <8e1b9a48-178b-4f93-6efd-e933ff1a4f54@georgianit.com>
 <20190624043751.GB11820@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20190624043751.GB11820@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 12:37:51AM -0400, Zygo Blaxell wrote:
> On Sun, Jun 23, 2019 at 10:45:50PM -0400, Remi Gauvin wrote:
> > On 2019-06-23 4:45 p.m., Zygo Blaxell wrote:
> >=20
> > > 	Model Family: Western Digital Green Device Model: WDC WD20EZRX-00DC0=
B0 Firmware Version: 80.00A80
> > >=20
> > > Change the query to 1-30 power cycles, and we get another model with
> > > the same firmware version string:
> > >=20
> > > 	Model Family: Western Digital Red Device Model: WDC WD40EFRX-68WT0N0=
 Firmware Version: 80.00A80
> > >=20
> >=20
> > >=20
> > > These drives have 0 power fail events between mkfs and "parent transid
> > > verify failed" events, i.e. it's not necessary to have a power failure
> > > at all for these drives to unrecoverably corrupt btrfs.  In all cases=
 the
> > > failure occurs on the same days as "Current Pending Sector" and "Offl=
ine
> > > UNC sector" SMART events.  The WD Black firmware seems to be OK with =
write
> > > cache enabled most of the time (there's years in the log data without=
 any
> > > transid-verify failures), but the WD Black will drop its write cache =
when
> > > it sees a UNC sector, and btrfs notices the failure a few hours later.
> > >=20
> >=20
> > First, thank you very much for sharing.  I've seen you mention several
> > times before problems with common consumer drives, but seeing one
> > specific identified problem firmware version is *very* valuable info.
> >=20
> > I have a question about the Black Drives dropping the cache on UNC
> > error.  If a transid id error like that occurred on a BTRFS RAID 1,
> > would BTRFS find the correct metadata on the 2nd drive, or does it stop
> > dead on 1 transid failure?
>=20
> Well, the 2nd drive has to have correct metadata--if you are mirroring
> a pair of disks with the same firmware bug, that's not likely to happen.

OK, I forgot the Black case is a little complicated...

I guess if you had two WD Black drives and they had all their UNC sector
events at different times, then the btrfs RAID1 repair should still
work with write cache enabled.  That seems kind of risky, though--what
if something bumps the machine and both disks get UNC sectors at once?

Alternatives in roughly decreasing order of risk:

	1.  Disable write caching on both Blacks in the pair

	2.  Replace both Blacks with drives in the 0-failure list

	3.  Replace one Black with a Seagate Firecuda or WD Red Pro
	(any other 0-failure drive will do, but these have similar
	performance specs to Black) to ensure firmware diversity

	4.  Find some Black drives with different firmware that have UNC
	sectors and see what happens with write caching during sector
	remap events:  if they behave well, enable write caching on
	all drives with matching firmware, disable if not

	5.  Leave write caching on for now, but as soon as any Black
	reports UNC sectors or reallocation events in SMART data, turn
	write caching off for the remainder of the drive's service life.

> There is a bench test that will demonstrate the transid verify self-repair
> procedure: disconnect one half of a RAID1 array, write for a while, then
> reconnect and do a scrub.  btrfs should self-repair all the metadata on
> the disconnected drive until it all matches the connected one.  Some of
> the data blocks might be hosed though (due to CRC32 collisions), so
> don't do this test on data you care about.
>=20
> >=20
> >=20



--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXRBfLgAKCRCB+YsaVrMb
nEsuAJ9RDOcSV/Y+eTaixSgailUo8A/IHQCgqCeYFH7/AJs6g3ZolqDr5sdIxCg=
=ovRh
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
