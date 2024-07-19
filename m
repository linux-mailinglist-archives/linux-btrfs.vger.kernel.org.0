Return-Path: <linux-btrfs+bounces-6579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64C93755A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37E81F213E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BBD7CF30;
	Fri, 19 Jul 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPTpe+IQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513779B8E
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378960; cv=none; b=rpV2yLlMe7fbRVjXeaBzuffSuyuRIjbjCBtpoS3DbczbScPf80Ysgl6RFJoKE7jUvjqjtGdeAVHnmLHDsTYXMo7AEHllJ6NVgmgvhBYAIol4JNQgbQP3fMPEePtzEH9hW+wl9EBI7HGDDEU37KW4k/maEq+hzoznMgNwJGQIpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378960; c=relaxed/simple;
	bh=Mv9gbkAFZYNe7ClvBYihMOojPH1P/2hga9VNV3m+7Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFG+pcN+eTblNubU9lJqRVYuN7mNQ/+y+WkzjKhvslL1kVm/1cPG6pfSZRUgjS925ihsRpKsYzrCFhxNm/1/RpT3ixojDKva8qpwbqPRwk7aYgK5k39gOE9aagyh4H80a2qqLn1S4LbUW7/UohTVXZ6NKSQ9bovrK8aN1ihpqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPTpe+IQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D537EC32782;
	Fri, 19 Jul 2024 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378959;
	bh=Mv9gbkAFZYNe7ClvBYihMOojPH1P/2hga9VNV3m+7Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPTpe+IQnFLpQ+KYVGooLdYf39KF6aF0OuIhcGuuhV8ldao8iRPmGRQiVm2xK1boj
	 yVFQTK951CAnHIJaJItipql3bBpxCAr/nMssFjuqqHTOrw1C8UuE+tIl5Xb/G3luMa
	 W9ZZYCKVgDOFMR2uJQ7SqveFQp2FilGysaAcTsJGHbnRfEh2Zjm+YlawFfb/AdOUFm
	 irxHVwFtKWwEKL8I9OhHvep1d3H6ZtM/jRUruDeB0AcCHljpHgjk+nNpB4X+gjiTxp
	 DhcRq5hz/AVI9+3Wmiuaxhi5xe0pzJgTMtCOZZz2oerB+l/MZTxO3kIfISU8oYcFd6
	 ipzAM2T8vAmkA==
Date: Fri, 19 Jul 2024 10:49:16 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sam James <sam@gentoo.org>, linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
Message-ID: <ffhpeboqqle45mro5mcv5d5ciucnc2cjc3cvzjhy3bt7wkc3qw@doi2d7fx2nl5>
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
 <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>
 <uhthjbiihonjjpqjkod7ao2kopeppbdgzhmdfuetu4c2tdzm6s@gevodksq2kku>
 <lwwiyeum2xhztlpwi4yuihz5rd4gyzf3k6c7zz5j6ynjq6ai6q@ior3lopynhdz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="soqytzggnnsukwp4"
Content-Disposition: inline
In-Reply-To: <lwwiyeum2xhztlpwi4yuihz5rd4gyzf3k6c7zz5j6ynjq6ai6q@ior3lopynhdz>


--soqytzggnnsukwp4
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
 <uhthjbiihonjjpqjkod7ao2kopeppbdgzhmdfuetu4c2tdzm6s@gevodksq2kku>
 <lwwiyeum2xhztlpwi4yuihz5rd4gyzf3k6c7zz5j6ynjq6ai6q@ior3lopynhdz>
MIME-Version: 1.0
In-Reply-To: <lwwiyeum2xhztlpwi4yuihz5rd4gyzf3k6c7zz5j6ynjq6ai6q@ior3lopynhdz>

On Fri, Jul 19, 2024 at 10:47:52AM GMT, Alejandro Colomar wrote:
> On Fri, Jul 19, 2024 at 10:39:06AM GMT, Alejandro Colomar wrote:
> > Hi Qu,
> >=20
> > On Fri, Jul 19, 2024 at 10:49:09AM GMT, Qu Wenruo wrote:
> > >=20
> > >=20
> > > =E5=9C=A8 2024/7/19 07:56, Alejandro Colomar =E5=86=99=E9=81=93:
> > > > Hi Sam!
> > > >=20
> > > > On Thu, Jul 18, 2024 at 10:54:40PM GMT, Sam James wrote:
> > > > > GCC 15 introduces a new warning -Wunterminated-string-initializat=
ion
> > > > > which causes, with the kernel's -Werror=3D..., the following:
> > > > > ```
> > > > > /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.41/work/linux-6.6/f=
s/btrfs/print-tree.c:29:49: error: initializer-string for array of =E2=80=
=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
> > > > >     29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_G=
ROUP_TREE"      },
> > > > >        |
> > > > >        ^~~~~~~~~~~~~~~~~~
> > > > > ```
> > >=20
> > > Great new GCC feature!
> >=20
> > Thanks!!  It's a pleasure to see it working.  :-)
> >=20
> > > And it's indeed too long, not only for the block group tree, but also
> > > for the future RAID_STRIPE_TREE too.
> >=20
> > Yep, there are two entries too long.
> >=20
> > > I believe we can just enlarge the string to 32 bytes for now.
> > > I'll send out a fix soon.
>=20
> Please add:
>=20
> Fixes: 9c54e80ddc6b ("btrfs: add code to support the block group root")

And also (I forgot)

Fixes: edde81f1abf29 ("btrfs: add raid stripe tree pretty printer")

> Reported-by: Sam James <sam@gentoo.org>
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Suggested-by: Alejandro Colomar <alx@kernel.org>
>=20
> And this will be useful:
>=20
> $ git describe --contains 9c54e80ddc6bd89596a4046d451908700476fd14
> v5.18-rc1~172^2~64
>=20
> Cheers,
> Alex
>=20
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--soqytzggnnsukwp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaaKIwACgkQnowa+77/
2zIEsw//SK0E5LoSwrRNZooAvEXSPDNALwKoJn0n+Kpqfte3K+jDZ/55qDoiTA96
i8OXP6jkk40Jxpg5CnR9iKE3TUkUnq0yx9dD/GmiG4zM3ifPt07HjWQ+g+cuwoH+
2TtcOxFhmm0cmEQJGQGsj2pQ2iY2IaZuvmY10lBo8mWwjnlz+3Vfh7/9EuY8X/ci
dcRWlaOYRD+V9PJm6IGuTDuLkl3bfns6e5r9EHbJ9pu20FSMV/s5PZwVtCUL4eFQ
a4VNiPGSffqUhESaufa15+CSTnWOyIOLlEq3JTT09XXmebUmEiPZSAbQi/DTGOjN
5Df2H/TucvOhVCzAhVRy+Uvod7GtIresD7+UTxBTEW5ALvpIbVpB/lglQuznAuRH
iV8aJMNcFxXKC/IGg4YnjPZTZof3Q7XT0tmHSuZdSJs40NNH4WYenrDYkZQOabug
6spQWRwLc2ZlBo+/l3IH9kDECtM//358dcyhEC+LcNbGYuvwp5SY5YUANZp7QTUg
la8nUYdaPGXZqDfR7Dfd39em7suzeULt6GQmYOV6bdjzLRwomvESdsMLhkSaLtNd
KBew5JUkA4g8gHujEM/WopAkyLMNpIkqwGQKvPdz5hLeQuSzfQctLiVY/N9Gu0fn
P7HwFdyU+IOrNwb5kl1BpWhLKQD8Hzfdb/8SKWA/LKpEkoAhisQ=
=dpFo
-----END PGP SIGNATURE-----

--soqytzggnnsukwp4--

