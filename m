Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967DBF5ADC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 23:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfKHWZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 17:25:58 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36238 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWZ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 17:25:58 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7A6074C11ED; Fri,  8 Nov 2019 17:25:57 -0500 (EST)
Date:   Fri, 8 Nov 2019 17:25:57 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Decoding "unable to fixup (regular)" errors
Message-ID: <20191108222557.GT22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold>
 <20191108220927.GR22121@hungrycats.org>
 <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 11:21:56PM +0100, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > btrfs found corrupted data on md1.  You appear to be using btrfs
> > -dsingle on a single mdadm raid1 device, so no recovery is possible
> > ("unable to fixup").
> >=20
> >> The system has ECC memory with md1 being a RAID1 which passes all heal=
th checks.
> >=20
> > mdadm doesn't have any way to repair data corruption--it can find
> > differences, but it cannot identify which version of the data is correc=
t.
> > If one of your drives is corrupting data without reporting IO errors,
> > mdadm will simply copy the corruption to the other drive.  If one
> > drive is failing by intermittently injecting corrupted bits into reads
> > (e.g. because of a failure in the RAM on the drive control board),
> > this behavior may not show up in mdadm health checks.
>=20
> Well, this is not cheap hardware...
> Possible, but not very likely IMHO

Even the disks?  We see RAM failures in disk drive embedded boards from
time to time.

> >> I tried to find the inodes behind the erroneous addresses without succ=
ess.
> >> e.g.
> >> $ btrfs inspect-internal logical-resolve -v -P 593483341824 /
> >> ioctl ret=3D0, total_size=3D4096, bytes_left=3D4080, bytes_missing=3D0=
, cnt=3D0, missed=3D0
> >> $ echo $?
> >> 1
> >=20
> > That usually means the file is deleted, or the specific blocks referenc=
ed
> > have been overwritten (i.e. there are no references to the given block =
in
> > any existing file, but a reference to the extent containing the block
> > still exists).  Although it's not possible to reach those blocks by
> > reading a file, a scrub or balance will still hit the corrupted blocks.
> >=20
> > You can try adding or subtracting multiples of 4096 to the block number
> > to see if you get a hint about which inodes reference this extent.
> > The first block found in either direction should be a reference to the
> > same extent, though there's no easy way (other than dumping the extent
> > tree with 'btrfs ins dump-tree -t 2' and searching for the extent record
> > containing the block number) to figure out which.  Extents can be up to
> > 128MB long, i.e. 32768 blocks.
>=20
> Thanks for the hint!
>=20
> > Or modify 'btrfs ins log' to use LOGICAL_INO_V2 and the IGNORE_OFFSETS
> > flag.
> >=20
> >> My kernel is 4.12.14-lp150.12.64-default (OpenSUSE 15.0), so not super=
 recent
> >> but AFAICT btrfs should be sane
> >> there. :-)
> >=20
> > I don't know of specific problems with csums in 4.12, but I'd upgrade t=
hat
> > for a dozen other reasons anyway.  One of those is that LOGICAL_INO_V2
> > was merged in 4.15.
> >=20
> >> What could cause the errors and how to dig further?
> >=20
> > Probably a silent data corruption on one of the underlying disks.
> > If you convert this mdadm raid1 to btrfs raid1, btrfs will tell you
> > which disk the errors are coming from while also correcting them.
>=20
> Hmm, I don't really buy this reasoning. Like I said, this is not
> cheap/consumer hardware.
>=20
> Thanks,
> //richard

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXcXrdQAKCRCB+YsaVrMb
nHw+AJ4gvvCkENUh1Vp+J/OM8dV1bMkXfACcC/bj4BmwdXArdG50Qttv9c+Evj0=
=Xe5M
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
