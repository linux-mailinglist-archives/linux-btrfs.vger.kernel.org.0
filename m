Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3CF5BE8
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 00:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKHXjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 18:39:49 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47130 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKHXjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 18:39:49 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8F02D4C143B; Fri,  8 Nov 2019 18:39:43 -0500 (EST)
Date:   Fri, 8 Nov 2019 18:39:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Decoding "unable to fixup (regular)" errors
Message-ID: <20191108233933.GU22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold>
 <20191108220927.GR22121@hungrycats.org>
 <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at>
 <20191108222557.GT22121@hungrycats.org>
 <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
In-Reply-To: <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 11:31:22PM +0100, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
> > An: "richard" <richard@nod.at>
> > CC: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> > Gesendet: Freitag, 8. November 2019 23:25:57
> > Betreff: Re: Decoding "unable to fixup (regular)" errors
>=20
> > On Fri, Nov 08, 2019 at 11:21:56PM +0100, Richard Weinberger wrote:
> >> ----- Urspr=FCngliche Mail -----
> >> > btrfs found corrupted data on md1.  You appear to be using btrfs
> >> > -dsingle on a single mdadm raid1 device, so no recovery is possible
> >> > ("unable to fixup").
> >> >=20
> >> >> The system has ECC memory with md1 being a RAID1 which passes all h=
ealth checks.
> >> >=20
> >> > mdadm doesn't have any way to repair data corruption--it can find
> >> > differences, but it cannot identify which version of the data is cor=
rect.
> >> > If one of your drives is corrupting data without reporting IO errors,
> >> > mdadm will simply copy the corruption to the other drive.  If one
> >> > drive is failing by intermittently injecting corrupted bits into rea=
ds
> >> > (e.g. because of a failure in the RAM on the drive control board),
> >> > this behavior may not show up in mdadm health checks.
> >>=20
> >> Well, this is not cheap hardware...
> >> Possible, but not very likely IMHO
> >=20
> > Even the disks?  We see RAM failures in disk drive embedded boards from
> > time to time.
>=20
> Yes. Enterprise-Storage RAID-Edition disks (sorry for the marketing buzzw=
ords).

Can you share the model numbers and firmware revisions?  There are a
lot of enterprise RE disks.  Not all of them work.

At least one vendor has the same firmware in their enterprise RE disks
as in their consumer drives, and it's unusually bad.  Apart from the
identical firmware revision string, the consumer and RE disks have
indistinguishable behavior in our failure mode testing, e.g.  they both
have write caching bugs on power failures, they both silently corrupt
a few blocks of data once or twice a drive-year...

> Even if one disk is silently corrupting data, having the bad block copied=
 to
> the second disk is even more less likely to happen.
> And I run the RAID-Health check often.

Your setup is not able to detect this kind of failure very well.
We've had problems with mdadm health-check failing to report errors
even in deliberate data corruption tests.  If a resync is triggered,
all data on one drive is blindly copied to the other.  You also have
nothing checking for integrity failures between mdadm health checks
(other than btrfs csum failures when the corruption propagates to the
filesystem layer, as shown above in your log).

We do a regression test where we corrupt every block on one disk in
a btrfs raid1 (even the superblocks) and check to ensure they are all
correctly reported and repaired without interrupting applications running
on the filesystem.  btrfs has a separate csum so it knows which version
of the block is wrong, and it checks on every read so it will detect
and report errors that occur between scrubs.

The most striking thing about the description of your setup is that you
have ECC RAM and you have a scrub regime to detect errors...but you have
both a huge gap in error detection coverage and a mechanism to propagate
errors across what is supposed to be a fault isolation boundary because
you're using mdadm raid1 instead of btrfs raid1.  If one of your disks
goes bad, not only will it break your filesystem, but you won't know
which disk you need to replace.

>=20
> Thanks,
> //richard

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXcX8rwAKCRCB+YsaVrMb
nGKKAJ0QGZnOXXSpV7I6T701pGv+BKUFugCbBrm4s06b7LMamO99eY5yLvBg0pQ=
=lHV+
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--
