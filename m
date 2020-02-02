Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5215000D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 00:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBBXes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 18:34:48 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35584 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBBXes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Feb 2020 18:34:48 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D48D65A5434; Sun,  2 Feb 2020 18:34:46 -0500 (EST)
Date:   Sun, 2 Feb 2020 18:34:46 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>
Cc:     Skibbi <skibbi@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: My first attempt to use btrfs failed miserably
Message-ID: <20200202233446.GT13306@hungrycats.org>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <a9069bcb-73d2-09fa-e156-a1a3037303c5@petaramesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GAoked8QSizNecZ5"
Content-Disposition: inline
In-Reply-To: <a9069bcb-73d2-09fa-e156-a1a3037303c5@petaramesh.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--GAoked8QSizNecZ5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2020 at 03:45:00PM +0100, Sw=E2mi Petaramesh wrote:
> Le 02/02/2020 =E0 13:45, Skibbi a =E9crit=A0:
> > So I decided to try btrfs on my new portable WD Password Drive
> > attached to Raspberry Pi 4. I created GPT partition, created luks2
> > volume and formatted it with btrfs. Then I created 3 subvolumes and
> > started copying data from other disks to one of the subvolumes. After
> > writing around 40GB of data my filesystem crashed. That was super fast
> > and totally discouraged me from next attempts to use btrfs :(
>=20
> For what it's worth, I've been using BTRFS for 5+ *years* on removable,
> encrypted hard disks, and use them daily on Raspberry Pis with 4.19
> kernels and *never* hit a single problem.

Same here, except I have seen problems as well as successes.  Some hints:

The log is incomplete but there is some evidence of USB disconnects.
These are bad.  Fix those before you try to use this hardware to store
data.

Disable write caching (hdparm -W0).  The worst case is a USB disconnect
while there are uncompleted writes still in the drive memory.  Filesystems
get severely damaged when that happens.  Most filesystems silently
corrupt your data when that happens.  If write cache is disabled (and
the USB-SATA bridge firmware isn't garbage) then a disconnect doesn't
do as much damage and most filesystems can recover from it.  btrfs is
very good at batching up writes so write caching does not contribute
significantly to performance.

Cables can be a near-bottomless source of problems, because a bad
cable will trigger USB disconnects.  I find that a USB data cable will
work for a certain number of connections and disconnections, and once
that number is exceeded the cable is garbage and should be recycled.
For cheaper cables that number can be as low as 5.  Some even fail on
the first connection.

Some USB->SATA bridge firmwares are broken, just swap it out with a
different model and it'll be fine (though it may be difficult to do this
with a WD Passport drive without taking the drive apart and placing the
drive in a generic USB drive enclosure).  It is not possible to tell
what board revision or chip/firmware revision is used from the outside,
you have to open the drive and look at the USB-SATA bridge electronics.
Sometimes you can buy two of the same model USB-SATA bridges from
the same shop on the same day and the boards (and bugs) are completely
different inside.  You may find one drive mysteriously works and another
"identical" drive does not.

If the drive disconnects, umount it before reconnecting.  Disable any
configuration settings that might try to hide a USB device disconnection
=66rom the upper storage layers.  btrfs normally detects this and sets
itself read-only, but if somehow that doesn't happen, the filesystem will
be destroyed because part of the commit history will be missing on disk.
On RAID1 arrays of USB devices it's more complicated, you need to run
replace or scrub on the disk that disconnected to reconstruct the
missing data from drives that didn't disconnect.

Once you've purged your setup of broken firmware and cables, it can run
for years without incident.

4.19 doesn't have metadata-corrupting bugs that I know of.

I would be wary of 32-bit ARM.  btrfs is most tested on amd64, and
other architectures sometimes have problems that amd64 simply does not,
especially on large (8T+) filesystems where uint32 isn't enough for a
device address.  That said, I have a dozen Raspberry Pis on 5.0.21 and
haven't encountered issues other than the usual SD card failure every
few years--but the largest filesystem on these is 128GB.

Also watch out for weak power supplies on Raspberry Pi boards.  The CPU
and memory run at a significantly lower voltage than the USB interface,
and one symptom of a power supply that is too small or too old is that
all the USB devices stop working reliably.

> The only time I lost a filesystem whas when I got hit by the infamous
> 5.2 bug, and it was on a classical laptop, not on a pi...
>
> Kind regards.
>=20

--GAoked8QSizNecZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjdckgAKCRCB+YsaVrMb
nNgPAKCFkozU++uJRFzA8IpCGjxGmeRLqQCguxxSRZn2UHrr+nx/7T4YRSstah0=
=QqJN
-----END PGP SIGNATURE-----

--GAoked8QSizNecZ5--
