Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEDB29EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 06:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfINE7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Sep 2019 00:59:30 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48246 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbfINE7a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Sep 2019 00:59:30 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E9433425A84; Sat, 14 Sep 2019 00:59:28 -0400 (EDT)
Date:   Sat, 14 Sep 2019 00:59:28 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix balance convert to single on 32-bit host CPUs
Message-ID: <20190914045928.GN22121@hungrycats.org>
References: <20190912235507.3DE794232AF@james.kirk.hungrycats.org>
 <7af81c39-d31a-1888-e7f3-615fa0eba877@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <7af81c39-d31a-1888-e7f3-615fa0eba877@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 10:24:08AM +0200, Johannes Thumshirn wrote:
> On 13/09/2019 01:55, Zygo Blaxell wrote:
> > Currently, the command:
> >=20
> > 	btrfs balance start -dconvert=3Dsingle,soft .
> >=20
> > on a Raspberry Pi produces the following kernel message:
> >=20
> > 	BTRFS error (device mmcblk0p2): balance: invalid convert data profile =
single
> >=20
> > This fails because we use is_power_of_2(unsigned long) to validate
> > the new data profile, the constant for 'single' profile uses bit 48,
> > and there are only 32 bits in a long on ARM.
> >=20
> > Fix by open-coding the check using u64 variables.
> >=20
> > Tested by completing the original balance command on several Raspberry
> > Pis.
> >=20
> > Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> > ---
> >  fs/btrfs/volumes.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 88a323a453d8..252c6049c6b7 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3906,7 +3906,11 @@ static int alloc_profile_is_valid(u64 flags, int=
 extended)
> >  		return !extended; /* "0" is valid for usual profiles */
> > =20
> >  	/* true if exactly one bit set */
> > -	return is_power_of_2(flags);
> > +	/*
> > +	 * Don't use is_power_of_2(unsigned long) because it won't work
> > +	 * for the single profile (1ULL << 48) on 32-bit CPUs.
> > +	 */
> > +	return flags !=3D 0 && (flags & (flags - 1)) =3D=3D 0;
>=20
> Would
> flags && IS_ALIGNED(flags)
>=20
> Work as well? IS_ALIGNED() should be type-save due to the typeof():
> #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
>=20
> Or maybe I'm missing something subtle?

Wouldn't that be
=09
	flags && IS_ALIGNED(flags, flags)

?

> Thanks,
> 	Johannes
> --=20
> Johannes Thumshirn                            SUSE Labs Filesystems
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5
> 90409 N=FCrnberg
> Germany
> (HRB 247165, AG M=FCnchen)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXXxzrAAKCRCB+YsaVrMb
nDB4AKCScbBn00gRTi5656jfUJmF0kVwBACaA9bmh4neb8Q84zaykWz7DiF78hI=
=rfsB
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
