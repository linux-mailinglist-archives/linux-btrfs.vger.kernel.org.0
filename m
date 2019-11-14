Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE3FBF5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 06:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfKNFVa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 00:21:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41694 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfKNFVa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 00:21:30 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 40C744D1213; Thu, 14 Nov 2019 00:21:29 -0500 (EST)
Date:   Thu, 14 Nov 2019 00:21:29 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Brian Hansen <dulanic@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: reflink copy now works with nocow?
Message-ID: <20191114052129.GA22121@hungrycats.org>
References: <CAMiuOHXH1ic6Mcz+o1uWLNMCK+iCinhR+nnZ8N1wTHQoEms-7Q@mail.gmail.com>
 <20191102193624.3411de0d@natsu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R92lf0Oi2sxyK3LA"
Content-Disposition: inline
In-Reply-To: <20191102193624.3411de0d@natsu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--R92lf0Oi2sxyK3LA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2019 at 07:36:24PM +0500, Roman Mamedov wrote:
> On Sat, 2 Nov 2019 08:49:37 -0500
> Brian Hansen <dulanic@gmail.com> wrote:
>=20
> > Hello,
> >=20
> > First time i've sent to this group but I am trying to figure out the
> > cause of this. Normal copy is working fine, but then if I use
> > --reflink it says invalid argument. Not sure how to read some of this,
> > but here is the strace.
> >=20
> > I'm running kernel v4.15
> >=20
> > Here is the full output of strace. I ran a strace on normal copy and
> > most looks similar so I'm not able to figure out much here...
> >=20
> > https://pastebin.com/raw/YmQ8FvCH
>=20
> At first I was going to say, "oh it's because you are using 'chattr +C', =
or
> mounted the filesystem as nocow, and reflink copying is prevented by thos=
e".
> In fact this article from 2014 confirms that to be the case:
> http://infotinks.com/btrfs-nodatacow-reflink-copies-snapshots/
>=20
> But then I tested on my machine, and what used to fail, now works:
>=20
>   # mkdir tmp
>   # chattr +C tmp
>   # echo abc > tmp/a
>   # cp -a --reflink=3Dalways tmp/a tmp/b
>   # lsattr tmp/
>   ----------------C-- tmp/a
>   ----------------C-- tmp/b
>=20
> According to strace, the clone IOCTL succeeds:
>=20
> ...
>   openat(AT_FDCWD, "tmp/b", O_WRONLY|O_CREAT|O_EXCL, 0600) =3D 4
>   fstat(4, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
>   ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) =3D 0
> ...
>=20
> Same on kernels 4.14.151, 4.14.113 and 4.9.189.
>=20
> So I wonder, is setting nocow via 'chattr +C' getting ignored now, or is =
there
> an improvement that it no longer prevents reflink copying?

reflink copies of nodatacow files should be OK.  'nodatacow' just means
'don't COW *unshared* extents in this file'.  If an extent is shared
by clone, dedupe, or snapshot then it is COW until only one reference
remains.

> --=20
> With respect,
> Roman

--R92lf0Oi2sxyK3LA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXczkWAAKCRCB+YsaVrMb
nBe3AKDi2I0xQJdX4IgGIjfmnDLY9zyunACgiTSFklAEqxbODvkyFis1l6G98Kc=
=M7mz
-----END PGP SIGNATURE-----

--R92lf0Oi2sxyK3LA--
