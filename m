Return-Path: <linux-btrfs+bounces-6280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA3929E48
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2ACDB21F8C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA938446B4;
	Mon,  8 Jul 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=lukasstraub2@web.de header.b="HjjijEGV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A23D994
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427211; cv=none; b=PFaPapk3yF1uPxrsvrNMbqT/DKa/0JFdyWkgsTOdW8xNE1QivkZiQJCtegm5nomeZN8ArAxf7sCMBEeVL6osVxve5/rSs+ZUWpU4znz5rA4LfX3c3UEYmIRMYtybydcMNW3dM6b5ewB+OBaW3n3HjOcA1G2KSBSolf/qvTwlMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427211; c=relaxed/simple;
	bh=BFA6M1sup5S6zVryvKghJybv93ZM8ZH9RjbedKwJQw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcCquQQNKYtI1rV+uBvVlhAahxA5LYDlXuIys4vVlm/id9CFb7yFK4a5xUN5OfaLgvlEbDSG5cPvgT9eWbIKTbcPveQ0K9IN0KChvkU859JWf/iCkTRxOmTTJJy/oUIXAD797wfQiUoR6zW8A9qbs7aHZeIMc8hpdNQZP5toXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=lukasstraub2@web.de header.b=HjjijEGV; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720427202; x=1721032002; i=lukasstraub2@web.de;
	bh=75dbBp2gwc0PF8XHc6rver8E7cBi0QYNjz8UFOK/9xU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HjjijEGV4WsaYRFDjJSoNDhBpa0zXyg/d3AIQCrladmF6jrBEOTfVzjJD3QMG3Sn
	 jlURHKPRaTxFCSWGiCAH894SlJQILHdhEoKcgeFfsqNW+wAy8vd6smOIedzTJRmW7
	 kgKpeUw50CPpK4BnWLgm1Uh7XcJZnRc+kxvLjcPSLr475L0xj2i+Fd0oosocJv5X4
	 lDzB6Krya2SYFL57ZQkrY8e58+N/F1fx+oz6lJZoO4hkSQtIxh0X/R5DgiQzYkdft
	 w4fWeDovnGBX6I3u/5xKp7IyqrxIzyjDGDYV+bOn11pFvw5rDlgnTZzmGZQMhYHr4
	 32PuVVUMQ+jnfvTn4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([89.246.98.79]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1sKbvz3RRW-00xDGU; Mon, 08
 Jul 2024 10:26:41 +0200
Date: Mon, 8 Jul 2024 10:26:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
Subject: Re: raid5 silent data loss in 6.2 and later, after "7a3150723061
 btrfs: raid56: do data csum verification during RMW cycle"
Message-ID: <20240708100927.652b2bc7@penguin>
In-Reply-To: <ZouGYZWkKM_W4hby@hungrycats.org>
References: <ZlqUe+U9hJ87jJiq@hungrycats.org>
	<a9d16fd4-2fec-40c7-94cc-c53aa208c9b9@gmx.com>
	<ZmO6IPV0aEirG5Vk@hungrycats.org>
	<5a8c1fbf-3065-4cea-9cf9-48e49806707d@suse.com>
	<ZouGYZWkKM_W4hby@hungrycats.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bvsPL_L5E4gZT7.R.K.KLn_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:rhZPF6qYMeMSMfyCIFkMQlKuu8Eo4mUkntrmIuwnk5vaEnTjolH
 nHcsmgzPdVrAkO9866tghE8+1G5zwaZmrxxRHxvKmpZY/n/z8JPzvqfsz/2vPczy82B4dhP
 V86l8LhRegKYBs/kraATUD3jQduZ/AJK6B0ZhLhiwTIT3HJD6DqTVUr1ilDblMn05OkVGuA
 kkVFWpPZcrLLksQjE5iIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9WIZd+XYRP8=;vVtrGsZ4WUeMUVNraYczFYbllZe
 R2Vi6nOtZma+zuHgsvnEFgEEnxMTW4WfeITvOUJsks86c/QEEUK+UUqBORnmarnEa+DvM2mdP
 dRuCXADbI7h93t63gO0C9Sts0CuY6taHfBg0d31riSCCIiYIialPREcyjpjDH1nHiHJIpoUCt
 G/pLJ3VgWTykX/CSLKG6dOD2M+fbWFLc79vGb42SO3mUiVKJ5wTuQpvFogXeLPu2JI5XlLFbb
 7JnXhMWZTrRkkVbKTKcjQ0d9jV6DE7wO2YBT1nukA3BPRQErMUDedZ0nDpNs/Ax+WI+RsI/oS
 CxdwvIXjIFoPYiqknLZZ+KgHVKUmdhoLbf4ngGHd1JKRNW3FTdp7LDdwwFbrAQG81v4feI842
 rQ7rVB062zDX2WOTIaVFnNZIbcsL8xezClxrKdCn96dJUvDXPCVVPJASUISfMStg8Yy8gT5qD
 nKcHpm+tpc9msQmk+XIW2pfetuwITGf4s4x82+SXG+6+tc+Ic4KXEfy90glB0CFW4XONAA5YW
 qE9trp+zpZ720IZyK6eK9cikQgMVLx8g9/L3eqhvi/sCWnnSV1mWW43faYH+6PAJWbkVtBelY
 OgU/eJiCQIxwZ2ypPFuClfqsxCdeDgSB65HmcMiOSim0mByPmyeZ4kyE2nzKTRryWz/dL81Ys
 y03nY1cr1fjpFWdDhWSGYu1iY9fM6GTrjVbNBQcVKNDAtkmS8wwBYXKg3rP77jJVHU0o3bI2f
 OOYQL7o9TOn+8MM4ukM9ySqcM2fb//5omzONdYSofh+DqmjmViq6S1sNLsIJzelJude6/OXBO
 k6sT9JWxr6LHqJ2wi/UtMGmjGwVCk2as3xlsen+dvtB1Q=

--Sig_/bvsPL_L5E4gZT7.R.K.KLn_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 02:25:37 -0400
Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:

> On Sat, Jun 08, 2024 at 12:50:35PM +0930, Qu Wenruo wrote:
> > =E5=9C=A8 2024/6/8 11:25, Zygo Blaxell =E5=86=99=E9=81=93: =20
> > > On Sat, Jun 01, 2024 at 05:22:46PM +0930, Qu Wenruo wrote:
> > > After this change, we now end up in an infinite loop:
> > >=20
> > > 1.  Allocator picks a stripe with some unrecoverable csum blocks
> > > and some free blocks
> > >=20
> > > 2.  Writeback tries to put data in the stripe
> > >=20
> > > 3.  rmw_rbio aborts after it can't repair the existing blocks
> > >=20
> > > 4.  Writeback deletes the extent, often silently (the application
> > > has to use fsync to detect it)
> > >=20
> > > 5.  Go to step 1, where the allocator picks the same blocks again
> > >=20
> > > The effect is pretty dramatic--even a single unrecoverable sector in
> > > one stripe will bring an application server to its knees, constantly
> > > discarding an application's data whenever it tries to write.  Once the
> > > allocator reaches the point where the "next" block is in a bad rmw st=
ripe,
> > > it keeps allocating that same block over and over again. =20
> >=20
> > I'm afraid the error path (no way to inform the caller) is an existing
> > problem. Buffered write can always success (as long as no ENOMEM/ENOSPC
> > etc), but the real writeback is not ensured to success.
> > It doesn't even need RAID56 to trigger.
> >=20
> > But "discarding" the dirty pages doesn't sound correct.
> > If a writeback failed, the dirty pages should still stay dirty, not
> > discarded.
> >=20
> > It may be a new bug in the error handling path. =20
>=20
> I found the code that does this.  It's more than 11 years old:
>=20
> commit 0bec9ef525e33233d7739b71be83bb78746f6e94
> Author: Josef Bacik <jbacik@fusionio.com>
> Date:   Thu Jan 31 14:58:00 2013 -0500
>=20
>     Btrfs: unreserve space if our ordered extent fails to work
>=20
>     When a transaction aborts or there's an EIO on an ordered extent or a=
ny
>     error really we will not free up the space we reserved for this order=
ed
>     extent.  This results in warnings from the block group cache cleanup =
in the
>     case of a transaction abort, or leaking space in the case of EIO on an
>     ordered extent.  Fix this up by free'ing the reserved space if we hav=
e an
>     error at all trying to complete an ordered extent.  Thanks,
>=20
> [...]

Before this escalates further in IMHO the wrong direction:

I think the current btrfs behavior correct. See also this paper[1] that
examines write failure of buffered io in different filesystems.
Especially Table 2. Ext4 and xfs for example do not discard the page
cache on write failure, but this is worse since now you have a mismatch
of what is in the cache and what is on disk. They do not retry to write
back the page cache.

The source of confusion here is rather that write errors do not happen
in the real world: Disks do not verify if they wrote data correctly and
neither does any layer (raid, etc.) above it.

Thus handling of write failure is completely untested in all
applications (See the paper again) and it seems the problems you see
are due to wrongly handling of write errors. The data loss is not
silent it's just that many applications and scripts do not use fsync()
at all.

I think the proper way of resolving this is for btrfs to retry writing
the extent, but to another (possibly clean) stripe. Or perhaps a fresh
raid5 block group altogether.

I very much approve btrfs' current design of handling (and reporting)
write errors in the most correct way possible.

Regards,
Lukas Straub


[1] https://www.usenix.org/system/files/atc20-rebello.pdf

--Sig_/bvsPL_L5E4gZT7.R.K.KLn_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmaLorgACgkQNasLKJxd
slhmng/9GwQ+uF8Gyxp6fvm3DJgS58OLZ6GmUZ0YDw3oq/xBMIi1F91cSHZBKq2p
obTl7Tb8tSns0IFAajaHSTmCmtM7LX6OfV9ltNI1f7TfbsKwNBOG+ikALsOreb5U
NHhG6ejnv+F/5aymMdxEEiIH8zkLkQ1XkM/wbgcxe+H1xUtgGw2HHqAEilPJKtYY
P3dLH7LwMU5cIni1bvuHJaABqMxaKGaYly1bNC+UGX6iCXJOQoKGRch5W/vQGi3z
JDyt854MkefIbMi4dx49spZXjRToD1eheZv9KxAS27FusjS75VmtVoot7cDlVvg7
+nImH1vliK9aga2dVFI1ybDkjpfpkVmeDkXywRhSos9PpzGUTLGEDIGanrogsv9V
G5OOkb+RWP+JqTs8wLaMxDi38yLn5YwhKGj3icQKVKbhQr0FrsdntUXnmwPRCcth
2ILH+q9zHY1L0BXMNg/LjAONhyNB4Fd4jauaiqOj3i21v6+XQl2GxmYgSZysBRFo
3GcSaw7pdQ0ddTcVnzqGbkdTRwoFSRDBlwLmUu5eEMBo6YnbxQReq1pPsnnl+re+
VW8mRWT13PaHM7E8sHOsrkhIpI87gvAmXn7GgvMFpjOHhy6bPPfqiMxOLGPpXNx/
wan3kEbtbP5+7HmrEG7zG0XGl4DAZYqosR8f4osnXzquQLqyx7Q=
=3fmG
-----END PGP SIGNATURE-----

--Sig_/bvsPL_L5E4gZT7.R.K.KLn_--

