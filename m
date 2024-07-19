Return-Path: <linux-btrfs+bounces-6576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0B93751F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 10:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC08D2822D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9E78281;
	Fri, 19 Jul 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZDz4HNg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E92AF07
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378346; cv=none; b=Ue9dVf2cI9eZ1B8xz7lO9L9uubFdX/zT1835hrq9k0PkiYvP8eD/qjmEGq3zyYFTIXo7SxcPosQb3RZbZGvvRnsuOrZBHhXNdcwrZpHdMO76/wVkc5STiBt1OmOqA8BKOvbMPd8KiHOKtiB6nCvQ0HG9qNhaHaY96/plXpDJy/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378346; c=relaxed/simple;
	bh=X14Fwun7nASwCYdzrwwhQ16EL4syyLUVnW0SDuhQMx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwAHRio5QchmIVEo5HqdkhHO9HIYHqHhJEmhPhBvaFrko64IPhFzAAsj3zAsam/SjmcC3G15F27m241+YAQS5JmVf0e90amoJaMBdH0re8RO1X5dVF+WfRXsXdMTIfsSj7IcvEWGQgQ3brgWrU3A6vwL2gbR7Zw3Ac/x2XX0EUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZDz4HNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10118C32782;
	Fri, 19 Jul 2024 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378345;
	bh=X14Fwun7nASwCYdzrwwhQ16EL4syyLUVnW0SDuhQMx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZDz4HNgrHk9AQpp4YUqtFj+RnedTFTWO/CWnILQmwOnMMWJGhYTPLVkke8qJ7RTE
	 7QCWm0TXl327+BzE+KZvVR5Iq1d1/obLCGoCC6QQjWy4AULzvtzerkCiPS3lFVWE0t
	 hIzMGrma4/9e86NlTZUKm5Nz2KqBqKxD55fivydHz5RbpzpBTzT4x4T+8UDbm8QSYC
	 wXjbYv6NnuMKKZo9ojvOEQTSugnaJZ/Sh22ZBGT9yhAAERRZmkWI8HARgMtEdCfhbH
	 OOZp5qMot9k9/bXkiZ7k71wff45xW+PvDGEhCZZMy2bj1r3av+yaZ7k4K2ExnPUw4v
	 3kgllRF/KW+YQ==
Date: Fri, 19 Jul 2024 10:39:02 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sam James <sam@gentoo.org>, linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
Message-ID: <uhthjbiihonjjpqjkod7ao2kopeppbdgzhmdfuetu4c2tdzm6s@gevodksq2kku>
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
 <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="omx3yx3rrqvzxyzt"
Content-Disposition: inline
In-Reply-To: <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>


--omx3yx3rrqvzxyzt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sam James <sam@gentoo.org>, linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
 <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>
MIME-Version: 1.0
In-Reply-To: <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>

Hi Qu,

On Fri, Jul 19, 2024 at 10:49:09AM GMT, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2024/7/19 07:56, Alejandro Colomar =E5=86=99=E9=81=93:
> > Hi Sam!
> >=20
> > On Thu, Jul 18, 2024 at 10:54:40PM GMT, Sam James wrote:
> > > GCC 15 introduces a new warning -Wunterminated-string-initialization
> > > which causes, with the kernel's -Werror=3D..., the following:
> > > ```
> > > /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.41/work/linux-6.6/fs/bt=
rfs/print-tree.c:29:49: error: initializer-string for array of =E2=80=98cha=
r=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
> > >     29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP=
_TREE"      },
> > >        |
> > >        ^~~~~~~~~~~~~~~~~~
> > > ```
>=20
> Great new GCC feature!

Thanks!!  It's a pleasure to see it working.  :-)

> And it's indeed too long, not only for the block group tree, but also
> for the future RAID_STRIPE_TREE too.

Yep, there are two entries too long.

> I believe we can just enlarge the string to 32 bytes for now.
> I'll send out a fix soon.
>=20
>=20
> On the other hand, it's better to do build time verification on those
> string length.
>=20
> Any good advice to craft some build time macro/functions to find the max
> string length of a const array?

I don't think you can write any magic macro for that.  But you can
specify

	CFLAGS +=3D -Werror=3Dunterminated-string-initialization

That should do what you want.

> Or at least check against the array size.
>=20
> Thank you guys!
> Qu

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--omx3yx3rrqvzxyzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaaJiYACgkQnowa+77/
2zK0Ag//bojgMxq9NPLmlbZJjlFHOXE3rT7Xpo2iv3ySD8x/WnGEZnHzEApeF4M0
QG6MDPy+TOjwTw1wLpF4paUcuEO/FhqPVSIDSk9cZyylUAIxIRv/36m0jJX+HFMi
rj5VEZb+lDVVIKDsy5nw1ikb6QUwI17U0UhUfUHeh2ozkeRiZqhChGiBjlHG4g/Q
b505IjplR/GkHceHjtVkQDgZB4ylP+9tdxWZzEvVNpmvmVwhn1cbulOdNLsSs1gs
bDFbjZ3Z+Tqnp5mxlq5znypnqY34puBTreUsA4o460J2TcI4rYtpXNWQ/8syYa6c
90FrblpuOilCJQE6Ry2GWnrQJPLq7mrwv55P/KJPMksHaEoRg1N0GJk5H0AhdDC1
gZ36BJBOq7KszV9Cg2VrkzHk3Up/wb5YDRSgXHP4ohYtZkZyl659ffYgU3uy6cFw
aKzqlxzRkbEePIKtmDoRuTrge50ahz4NSD5FrqqHPF0hfHB8+h8t7ts2J4YGsM63
oRPgy02R7EMx3W6JwumJ8VeXlrvdsk6o6CRAPHfmY9rtEa6idO2Osvs+6su2fFfd
ZpipwLls0kpU/yZoquocHY165Cr1QUqVgPGgPZgVEuexxO5GNwhctD9Xk6z9mTFL
Kp4o+WAsj9FyHDnfz3rEuSI3sxN6zJ1veh5iJBpBRI79jWSoong=
=I3dH
-----END PGP SIGNATURE-----

--omx3yx3rrqvzxyzt--

