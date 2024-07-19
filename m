Return-Path: <linux-btrfs+bounces-6577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B893752B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882DDB22074
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2A78C76;
	Fri, 19 Jul 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7MHl+xg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350B6EB7D
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378492; cv=none; b=t0ot0OvTu8lAniyHWmfmlSh1O4KTg71GKSzzyD4X12+xWk0fQGEHqB5q+VJa2/KJbBM1qF+647KTmpMlPsbCbffNfK6osVvsrx6pg4YGBipWWexKoh4cx2XH01F7i6P8+k163oDausHIDdHC44ju4NduqqWx9AZQ3oxYAOvHPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378492; c=relaxed/simple;
	bh=JJrC0P8Ke8NOWpW7ECRqI+ZGVrhFAwCZKnsHtOtAwsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTKV3xb4uXuxFpKd8ZQXbgoW57adZLDXnLymmUAzIybTxufoIeh5hX607/0Xu7pJlrXXG5pXoAChV+08knKfKpyU/wXAf1IzdgIA3uHKLC1vZPR0asQ2fXgt8xEfUKNFyK5Hb5AM2S3DocXmKjXfCk6GKR7uS5kYIO6iBjSzLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7MHl+xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E141C32782;
	Fri, 19 Jul 2024 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378491;
	bh=JJrC0P8Ke8NOWpW7ECRqI+ZGVrhFAwCZKnsHtOtAwsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7MHl+xgUl1XEh1OiwaEHJNqp9SJevk6QsVc6oSGqxzX6sr+HUxYbxMsgax+/Ee/D
	 bfBE6ZbMGmO6gDDdwx5L+cnY9TRybe7WK7meIQ+xZYJpi59qqswoiwLIW/sBkyJ57N
	 GAlYZA5nsM/BiAzpz37lkZcNyfrssG4axLoX5nnkT9LVE+PMPr9Ri1lO2mnkydrwm0
	 jfjp9MZo01P3SQ5uj67YOK9KriAm115w45y8SYFCu9pj8ZuppCSQVPy7FjQ8XRsUIe
	 2D+NHbHuNtFnrDobajM9fpJEUpGd7dFMcyB2ij029FjB8cuPyT3x+LcjuAlsG8hrRd
	 ow8w+LmMiyWwA==
Date: Fri, 19 Jul 2024 10:41:29 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
Message-ID: <pp26lxmfippmqfciaibkeioyctl26fchx7udp6d2klhuuksdrv@lxbts3ydopvr>
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
 <87y15xykug.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmzll4js3y6jdwcb"
Content-Disposition: inline
In-Reply-To: <87y15xykug.fsf@gentoo.org>


--pmzll4js3y6jdwcb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
 <87y15xykug.fsf@gentoo.org>
MIME-Version: 1.0
In-Reply-To: <87y15xykug.fsf@gentoo.org>

Hi Sam,

On Fri, Jul 19, 2024 at 07:08:55AM GMT, Sam James wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > Hi Sam!
> >
> > On Thu, Jul 18, 2024 at 10:54:40PM GMT, Sam James wrote:
> >> GCC 15 introduces a new warning -Wunterminated-string-initialization
> >> which causes, with the kernel's -Werror=3D..., the following:
> >> ```
> >> /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.41/work/linux-6.6/fs/btr=
fs/print-tree.c:29:49: error: initializer-string for array of =E2=80=98char=
=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
> >>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_T=
REE"      },
> >>       |
> >>       ^~~~~~~~~~~~~~~~~~
> >> ```
> >>=20
> >> It was introduced in https://gcc.gnu.org/PR115185. I don't have time
> >> today to check the case to see what the best fix is, but CCing Alex who
> >> wrote the warning implementation in case he has a chance.
> >
> > Thanks for forwarding the report.  It looks like a legit diagnostic.  It
> > seems like a bug.
>=20
> Thank you for analysing it so quickly!

grepc(1) makes it easy.  :-)

> I normally try to for bug reports
> but I'd already hit an unrelated kernel issue I was debugging so I
> didn't want to worry about it for now.
>=20
> > [...]
>=20
> > The fix would be to add at least one byte to that array size.  Possibly
> > make it 32 for alignment.  But I don't know if that array size is fixed
> > by any ABI, so the maintainer will be better placed to find the suitable
> > fix.
> >
> > The only alternatives I see are
> >
> > -  Use a larger number of elements for that array (1 would be enough).
> > -  Use a shorter string so that it fits the 16 bytes.
> >
> > Have a lovely night!
>=20
> You too :)

Thanks :)

> It might be worth making a list of "real bugs the warning found" as
> stuff gets ported over the next few months.

Hmmm, sounds good.  I'll try to build a list of related links and
commits.

Have a lovely day!
Alex

>=20
> > Alex
>=20
> thanks,
> sam



--=20
<https://www.alejandro-colomar.es/>

--pmzll4js3y6jdwcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaaJrgACgkQnowa+77/
2zLkjg//SNh73eSl/hGOf51QP1CZxwV4wLP78/LhLhWCJtDMqYhFeFEbDEug2KxA
cywsZVTmqD8XRBDCRC8gWJ3wXeL7SNtyoTg6q3uQFVeYOqLNqjxl5jfySM+m67hx
P0MTrhBhw0lFGm/ZUQr1zBwyomC9EPflUEJ/mriD8REK3rr5Qi7LcQZwFbRchR9/
XlVb9UuMmmROYhJI4ZiQorHJAlY+0g4gd0iff8ScF31WgjAAbXaiKVHMi8KMvTh8
wnCvWVzDp+ZRSbYalDde6I3UU5HIqPrKJcu0BMAEMv7FMkECck0IjaBZ4ToujvfG
KFLK1Wky7qS3TVZfeSiTYsDRofZ9/gXg2HSYGgRIC8qAS0+Q8shZNOMxKwSX2JYD
zmdL5AXgUfRoWNjL4y4brEM39GIij2rQamDRTb/rNFu0+IsFqOvHeA73MkDfSN4E
5Y8FR8aUPOIPFEvZG2rdMIWLwve0KM0ooM6Je+1G7sUIfvUmQRFT//1BxRw1Qgrt
RT3MvIYflIRt2pJCbGRQOtjBPGGcsreccUUjXxsVyrPstY0WerYExLrnDI/RXyWN
Fa9Df/JowqZOZLOnuSltQPR3oMC0rpxQn1AIZfnTUvZIZTYrizbpe529tf6k2HN7
Jky9BKecVwyS/dP/UlBuJ5zZ5d/i5kRyGEwe9Z1x3xk9FhSERBk=
=SpOZ
-----END PGP SIGNATURE-----

--pmzll4js3y6jdwcb--

